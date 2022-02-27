const { parseEther } = require("ethers/lib/utils");

async function main() {
    const SETUP = await ethers.getContractFactory("Setup");
    const EXPLOIT = await ethers.getContractFactory("Exploit");

    const setup = await SETUP.deploy();
    const ctf = await ethers.getContractAt(
        "SheerLocking",
        await setup.instance()
    );

    console.log("solved:", await setup.isSolved());

    await EXPLOIT.deploy(ctf.address, { value: parseEther("1") });

    console.log("solved:", await setup.isSolved());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });