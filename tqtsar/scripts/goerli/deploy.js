const { parseEther } = require("ethers/lib/utils");
const hre = require("hardhat");

function sleep(seconds) {
  return new Promise((resolve) => setTimeout(resolve, seconds * 1000));
}

async function main() {
  const SETUP = await ethers.getContractFactory("Setup");

  const setup = await SETUP.deploy({ value: parseEther("0.000001") });
  await setup.deployed();

  const ctf = await ethers.getContractAt(
    "Fundraising",
    await setup.instance()
  );

  console.log("Deployed setup to", setup.address);
  console.log("Deployed ctf to", ctf.address);

  // wait for etherscan to index
  await sleep(300);

  // verify
  await hre.run("verify:verify", {
    address: "0x0dCb022a9927613f1B4B23F4F893515BA196c5c5",
  });
  await hre.run("verify:verify", {
    address: "0x44898e95E81600e7aD0a85F7e1A5daA987BC1365",
    constructorArguments: [parseEther("0.000001"), parseEther("1")],
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
