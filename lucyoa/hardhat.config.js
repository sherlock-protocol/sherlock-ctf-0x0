require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

const ETHERSCAN_API = process.env.ETHERSCAN_API || "";
const ALCHEMY_API_KEY_GOERLI = process.env.ALCHEMY_API_KEY_GOERLI || "";
const PRIVATE_KEY = process.env.PRIVATE_KEY || "";


module.exports = {
  solidity: "0.8.0",
  etherscan: {
    apiKey: ETHERSCAN_API,
  },
  networks: {
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY_GOERLI}`,
      gasPrice: 900000000000,
      accounts: [PRIVATE_KEY].filter((item) => item !== ""),
    },
  },
};
