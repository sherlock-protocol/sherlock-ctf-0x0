const { parseEther } = require("ethers/lib/utils");

async function main() {
  // const [owner, attacker, addr2] = await ethers.getSigners();
  const SETUP = await ethers.getContractFactory("Setup");
  const EXPLOIT = await ethers.getContractFactory("Exploit");

  const setup = await SETUP.deploy();
  const ctf = await ethers.getContractAt(
    "Unbreakable",
    await setup.instance()
  );

  console.log("solved:", await setup.isSolved());
  exploit = await EXPLOIT.deploy(ctf.address);
  await exploit.finalize();
  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
