import { ethers } from "hardhat";

import type { HardhatRuntimeEnvironment } from "hardhat/types";
import type { DeployFunction, Deployment } from "hardhat-deploy/types";

const func: DeployFunction = async function (env) {
  const { deploy } = env.deployments;
  const { deployer } = await env.getNamedAccounts();

  await deploy("Setup", { from: deployer, log: true });
};

export default func;
