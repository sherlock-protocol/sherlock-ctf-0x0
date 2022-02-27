const { parseEther } = require("ethers/lib/utils");
const { ethers } = require("hardhat");
const hre = require("hardhat");

function sleep(seconds) {
  return new Promise((resolve) => setTimeout(resolve, seconds * 1000));
}

async function main() {
  const SETUP = await ethers.getContractFactory("Setup");

  console.log('BEGINNING SETUP DEPLOYMENT');

  const setup = await SETUP.deploy({ value: parseEther("1") });
  await setup.deployed();

  const ctf = await ethers.getContractAt("CollisionExchange", await setup.exchange());
  const orderBook = await ethers.getContractAt("OrderBook", await setup.orderBook());

  console.log("Deployed setup to", setup.address);
  console.log("Deployed ctf to", ctf.address);
  console.log("Deployed orderBook to", orderBook.address);

  // wait for etherscan to index
  await sleep(300);

  verify
  await hre.run("verify:verify", {
    address: setup.address,
  });
  await hre.run("verify:verify", {
    address: ctf.address,
  });
  await hre.run("verify:verify", {
    address: orderBook.address,
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
