// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {

    const SETUP = await ethers.getContractFactory('Setup');
    const EXPLOIT = await ethers.getContractFactory('Exploit');

    const setup = await SETUP.deploy();
    
    console.log('Challenge Address', _addr);
    console.log('Setup Address', setup.address);


    exploit = await EXPLOIT.deploy(combination.address);
    await exploit.finalize(combination.address);

    console.log('Solved :',await setup.isSolved());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
