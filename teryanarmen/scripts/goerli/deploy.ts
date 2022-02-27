
import { ethers } from "hardhat";
import { parseEther } from "ethers/lib/utils";
const hre = require("hardhat");
// @ts-ignore
function sleep(seconds) {
    return new Promise((resolve) => setTimeout(resolve, seconds * 1000));
}

async function main() {
    const SETUP = await ethers.getContractFactory("Setup");

    const setup = await SETUP.deploy({ value: parseEther("1") });
    await setup.deployed();

    const ctf = await ethers.getContractAt(
        "Challenge2",
        await setup.instance()
    );

    console.log("Deployed setup to", setup.address);
    console.log("Deployed ctf to", ctf.address);

    // wait for etherscan to index
    await sleep(300);

    // verify, throws error?
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