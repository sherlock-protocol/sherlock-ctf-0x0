//npx hardhat compile
//npx hardhat run scripts/solving.js

const hre = require("hardhat");
const ethers = hre.ethers;
const { parseEther } = require("ethers/lib/utils");

async function main() {
    const SETUP = await ethers.getContractFactory("Setup");
    const EXPLOIT = await ethers.getContractFactory("Exploit");

    const setup = await SETUP.deploy({ value: parseEther("0.0000374") });
    const ctf = await ethers.getContractAt(
        "StableSwap2",
        await setup.instance()
    );

    console.log("Before exploit - solved:", await setup.isSolved());

    await EXPLOIT.deploy(ctf.address);

    console.log("After exploit  - solved:", await setup.isSolved());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });