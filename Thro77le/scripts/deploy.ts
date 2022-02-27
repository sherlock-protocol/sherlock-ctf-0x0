import hre from "hardhat";
import { ethers } from "hardhat";

function sleep(seconds: number) {
  return new Promise((resolve) => setTimeout(resolve, seconds * 1000));
}

async function main() {
  const SETUP = await ethers.getContractFactory("Setup");

  const setup = await SETUP.deploy();
  await setup.deployed();

  const ctf = await ethers.getContractAt("Challenge", await setup.challenge());

  console.log("Deployed setup to", setup.address);
  console.log("Deployed ctf to", ctf.address);

  // wait for etherscan to index
  await sleep(30);

  // verify
  await hre.run("verify:verify", { address: setup.address });
  // await hre.run("verify:verify", { address: ctf.address });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });