const { expect } = require("chai");
const { parseEther } = require("ethers/lib/utils");
const { ethers } = require("hardhat");

describe("MonopolyExploiter", function () {
  before(async function () {
    this.SETUP = await ethers.getContractFactory("Setup");
    this.setup = await this.SETUP.deploy({ value: parseEther("1") });
    await this.setup.deployed();
    this.ctf = await ethers.getContractAt("Monopoly", await this.setup.instance());
  })

  it("Should have CTF contract not equal address zero.", async function () {
    expect(await this.ctf).to.not.equal(0x0);
  });

  it("Should have CTF contract not be solved.", async function () {
    expect(await this.setup.isSolved()).to.equal(false);
  });

  // Using Exploit.sol
  it("Should successfully deploy exploit.", async function () {
    this.EXPLOIT = await ethers.getContractFactory("MonopolyExploiter");
    this.exploit = await this.EXPLOIT.deploy(this.ctf.address, { value: parseEther("0.25") });
    await this.exploit.deployed();
  })

  it("Should be solved by the exploit.", async function () {
    expect(await this.setup.isSolved()).to.equal(true);
  })
});