import { ethers } from "hardhat";
import { expect } from "chai";

import type { ContractFactory } from "ethers";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import type { Setup, Exploit, BuiltByANoob } from "../typechain-types";

const { parseUnits } = ethers.utils;

describe("Example", () => {
  let owner: SignerWithAddress;
  let alice: SignerWithAddress;
  let bob: SignerWithAddress;

  let Exploit: ContractFactory;
  let setup: Setup;
  let exploit: Exploit;
  let victim: BuiltByANoob;

  beforeEach(async () => {
    [owner, alice, bob] = await ethers.getSigners();

    let Setup = await ethers.getContractFactory("Setup");
    Exploit = await ethers.getContractFactory("Exploit");

    setup = (await Setup.deploy()) as Setup;

    const [deployLog] = await ethers.provider.getLogs({
      address: setup.address,
    });

    const [victimAddress] = ethers.utils.defaultAbiCoder.decode(
      ["address"],
      deployLog.data
    );

    victim = (await ethers.getContractAt(
      "BuiltByANoob",
      victimAddress,
      owner
    )) as BuiltByANoob;
  });

  it("works", async () => {
    await Exploit.deploy(victim.address);

    expect(await setup.isSolved()).to.eq(true);
  });
});
