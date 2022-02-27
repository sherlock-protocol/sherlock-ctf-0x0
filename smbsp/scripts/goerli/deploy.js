const { parseEther } = require("ethers/lib/utils");
const hre = require("hardhat");

function sleep(seconds) {
  return new Promise((resolve) => setTimeout(resolve, seconds * 1000));
}

async function main() {
  const SETUP = await ethers.getContractFactory("Setup");

  const setup = await SETUP.deploy({ value: parseEther("1") });
  await setup.deployed();

  const ctf = await ethers.getContractAt(
    "CollectReward",
    await setup.instance()
  );

  console.log("Deployed setup to", setup.address);
  console.log("Deployed ctf to", ctf.address);

  // wait for etherscan to index
  await sleep(300);

  // verify
  await hre.run("verify:verify", {
    address: setup.address,
  });
  await hre.run("verify:verify", {
    address: ctf.address,
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
