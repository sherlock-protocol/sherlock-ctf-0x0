const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Combination", function () {

  let setup;
  let combination;
  let exploit;

  it("Solve", async () => {
    let Setup = await ethers.getContractFactory('Setup');
    let Combination = await ethers.getContractFactory('Combination');
    let Exploit = await ethers.getContractFactory('Exploit');

    setup = await Setup.deploy();
    let _addr = await setup.combination();
    
    console.log('Challenge Address', _addr);

    combination = await Combination.attach(_addr);

    exploit = await Exploit.deploy(combination.address);
    await exploit.finalize(combination.address);

    console.log(await setup.isSolved());

    expect(await setup.isSolved()).to.equal(true);
  })
});
