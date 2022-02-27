const { parseEther } = require("ethers/lib/utils");

async function main() {
  const SETUP = await ethers.getContractFactory("Setup");
  const EXPLOIT = await ethers.getContractFactory("Exploit");

  const setup = await SETUP.deploy({ value: parseEther("1") });
  const ctf = await ethers.getContractAt("Challenge", await setup.instance());

  console.log("solved:", await setup.isSolved());

  const exp = await EXPLOIT.deploy(ctf.address);

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
