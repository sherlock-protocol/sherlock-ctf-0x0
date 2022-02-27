import '@nomiclabs/hardhat-waffle';
import { HardhatUserConfig } from "hardhat/config";
import "@typechain/hardhat";
import "@nomiclabs/hardhat-etherscan";

require("dotenv").config();

const ETHERSCAN_API = process.env.ETHERSCAN_API || "";
const ALCHEMY_API_KEY_GOERLI = process.env.ALCHEMY_API_KEY_GOERLI || "";
const PRIVATE_KEY = process.env.PRIVATE_KEY || "";

const config: HardhatUserConfig = {
    solidity: "0.8.4",
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
    typechain: {
        outDir: "types",
        target: "ethers-v5",
    },
  };

export default config;
