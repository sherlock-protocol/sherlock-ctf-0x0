require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require('dotenv').config();

const ETHERSCAN_API=process.env.ETHERSCAN_API;
const INFURA_API=process.env.INFURA_API;
const PRIVATE_KEY=process.env.PRIVATE_KEY;

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  etherscan: {
    apiKey:ETHERSCAN_API,
  },
  networks: {
    goerli: {
      url:`https://goerli.infura.io/v3/${INFURA_API}`,
      accounts: [`0x${PRIVATE_KEY}`],
    }
  }
};
