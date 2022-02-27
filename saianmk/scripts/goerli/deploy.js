// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

const sleep = seconds => new Promise(resolve => setTimeout(resolve, seconds * 1000));

async function main() {

  const SETUP = await ethers.getContractFactory('Setup');
  const COMBINATION = await ethers.getContractFactory('Combination');

  const setup = await SETUP.deploy();

  // await sleep(100);

  let _addr = await setup.combination();
  
  console.log('Challenge Address', _addr);
  console.log('Setup Address', setup.address);

  const combination = await COMBINATION.attach(_addr);

  await sleep(300);

  await hre.run("verify:verify", {
    address: setup.address
  });

  await hre.run("verify:verify", {
    address: combination.address,
    constructorArguments: [32,2,8,2,180],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
