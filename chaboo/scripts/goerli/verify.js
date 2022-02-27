const { parseEther } = require("ethers/lib/utils");
const hre = require("hardhat");

function sleep(seconds) {
  return new Promise((resolve) => setTimeout(resolve, seconds * 1000));
}

async function main() {
  const setup = await ethers.getContractAt("Setup", "0x0a73CA730FaF56126487196a4B7E10B2A9B3df67");
  const ctf = await ethers.getContractAt("SwissTreasury", "0x014D1921A1237b6e8fF3FA960333329667F7e242");

  console.log("Deployed setup to", setup.address);
  console.log("Deployed ctf to", ctf.address);

  // verify
  await hre.run("verify:verify", {
    address: ctf.address,
  });
  await hre.run("verify:verify", {
    address: setup.address,
  });

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
