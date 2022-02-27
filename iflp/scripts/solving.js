const { parseEther } = require('ethers/lib/utils');

async function main() {
  const LOLLERCOASTER = await ethers.getContractFactory(
    'contracts/Lollercoaster.sol:Lollercoaster'
  );
  const lollercoaster = await LOLLERCOASTER.deploy();
  console.log('Deployed lollercoaster to', lollercoaster.address);
  const SETUP = await ethers.getContractFactory('Setup');
  const EXPLOIT = await ethers.getContractFactory('Exploit');

  const setup = await SETUP.deploy({ value: parseEther('1') });
  await setup.deployed();
  const ctf = await ethers.getContractAt('ExampleQuizExploit', await setup.instance());
  await ctf.initialize(lollercoaster.address);
  console.log('solved:', await setup.isSolved());

  await EXPLOIT.deploy(ctf.address, { value: parseEther('1') });

  console.log('solved:', await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
