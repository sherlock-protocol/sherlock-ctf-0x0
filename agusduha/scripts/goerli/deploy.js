const { parseEther } = require("ethers/lib/utils");
const hre = require("hardhat");

function sleep(seconds) {
  return new Promise((resolve) => setTimeout(resolve, seconds * 1000));
}

async function main() {
  const SETUP = await ethers.getContractFactory("Setup");

  const setup = await SETUP.deploy({ value: parseEther("0.2") });
  await setup.deployed();

  const ctf = await ethers.getContractAt("KingVault", await setup.instance());

  const kingVault = await setup.kingVault();
  const setupData = await setup.data();

  console.log("Deployed setup to", setup.address);
  console.log("Deployed ctf proxy to", ctf.address);
  console.log("Deployed ctf implementation to", kingVault);

  // wait for etherscan to index
  await sleep(300);

  console.log("Verifying...");

  // verify
  await hre.run("verify:verify", {
    address: setup.address,
  });
  await hre.run("verify:verify", {
    address: kingVault,
  });
  await hre.run("verify:verify", {
    address: ctf.address,
    constructorArguments: [kingVault, setupData],
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
