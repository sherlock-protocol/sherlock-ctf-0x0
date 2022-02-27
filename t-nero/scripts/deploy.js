const hre = require("hardhat");
const { parseEther } = require("ethers/lib/utils");
const { ethers } = require("hardhat");

function sleep(seconds) {
  return new Promise((resolve) => setTimeout(resolve, seconds * 1000));
}

async function main() {
  const SETUP = await ethers.getContractFactory("Setup");

  const setup = await SETUP.deploy({ value: parseEther("1") });
  await setup.deployed();

  const ctf = await ethers.getContractAt("Monopoly", await setup.instance());
  const gameVault = await ethers.getContractAt("gameVault", await ctf.vault());

  console.log("Deployed Setup to", setup.address);
  console.log("Deployed Monopoly to", ctf.address);
  console.log("Deployed gameVault to", gameVault.address);

  // wait for etherscan to index
  await sleep(300);

  // verify
  await hre.run("verify:verify", {
    address: setup.address,
  });
  await hre.run("verify:verify", {
    address: ctf.address,
  });
  await hre.run("verify:verify", {
    address: gameVault.address
  })
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
