// npx hardhat test

const { expect } = require("chai");
const { parseEther } = require("ethers/lib/utils");

describe("Deployment tests", function () {
    const FAUCET_VALUE = 1000;
    const STABLECOIN_POOL_VALUE = 10000;
    let setup;
    let ctf;
    let setupValue;
    beforeEach(async function () {
        let SETUP = await ethers.getContractFactory("Setup");
        setupValue = ethers.BigNumber.from(parseEther("0.0000374"));
        setup = await SETUP.deploy({ value: setupValue });
        await setup.deployed();
        ctf = await ethers.getContractAt(
            "StableSwap2",
            await setup.instance()
        );
    });
    describe("Setup contract", function () {
        it("Should still have initial value", async function () {
            expect(await ethers.provider.getBalance(setup.address)).to.equal(setupValue);
        });
        it(`Should still have ${FAUCET_VALUE} USDC for faucet`, async function () {
            let USDC = await ethers.getContractAt(
                "TestERC20",
                await setup.USDC()
            );
            expect(await USDC.balanceOf(setup.address)).to.equal(ethers.BigNumber.from(1000));
        });
        it(`Faucet should give ${FAUCET_VALUE} USDC`, async function () {
            const accounts = await hre.ethers.getSigners();
            let USDC = await ethers.getContractAt(
                "TestERC20",
                await setup.USDC()
            );
            let initialBalance = await USDC.balanceOf(accounts[0].address);
            await setup.faucet(FAUCET_VALUE);
            let newBalance = await USDC.balanceOf(accounts[0].address);
            expect(initialBalance).to.equal(0);
            expect(newBalance).to.equal(FAUCET_VALUE);
        });
        it(`Faucet will not give more than ${FAUCET_VALUE} USDC`, async function () {
            await expect(setup.faucet(FAUCET_VALUE + 1)).to.be.revertedWith('ERC20: transfer amount exceeds balance');
        });
    });
    describe("StableSwap2 contract", function () {
        it("Should not have fourth stablecoin in a pool", async function () {
            await expect(ctf.underlying(3)).to.be.revertedWith('');
        });
        it(`Should have USDC, USDT, BUSD in pool and pool should have ${STABLECOIN_POOL_VALUE} from each stablecoin`, async function () {
            let stablecoinAmount = ethers.BigNumber.from(STABLECOIN_POOL_VALUE);
            let USDC = await ethers.getContractAt(
                "TestERC20",
                await ctf.underlying(0)
            );
            let USDT = await ethers.getContractAt(
                "TestERC20",
                await ctf.underlying(1)
            );
            let BUSD = await ethers.getContractAt(
                "TestERC20",
                await ctf.underlying(2)
            );
            expect(await USDC.symbol()).to.equal("USDC");
            expect(await USDT.symbol()).to.equal("USDT");
            expect(await BUSD.symbol()).to.equal("BUSD");
            expect(await USDC.balanceOf(ctf.address)).to.equal(stablecoinAmount);
            expect(await USDT.balanceOf(ctf.address)).to.equal(stablecoinAmount);
            expect(await BUSD.balanceOf(ctf.address)).to.equal(stablecoinAmount);
        });
        it("Should not allow for regular user to invoke addCollateral function", async function () {
            let USDC = await ethers.getContractAt(
                "TestERC20",
                await ctf.underlying(0)
            );
            await expect(ctf.addCollateral(USDC.address)).to.be.revertedWith('Ownable: caller is not the owner');
        });
        it("Should allow to mint supply and increase user balance", async function () {
            const accounts = await hre.ethers.getSigners();
            await setup.faucet(FAUCET_VALUE);
            let amounts = [];
            amounts.push(ethers.BigNumber.from(FAUCET_VALUE));
            amounts.push(ethers.BigNumber.from(0));
            amounts.push(ethers.BigNumber.from(0));
            let USDC = await ethers.getContractAt(
                "TestERC20",
                await ctf.underlying(0)
            );
            USDC.approve(ctf.address, STABLECOIN_POOL_VALUE);
            let initialSupply = await ctf.supply();
            await ctf.mint(amounts);
            let balance = await ctf.balances(accounts[0].address);
            expect(balance).to.equal(FAUCET_VALUE);
            expect(await ctf.supply()).to.equal(initialSupply.add(balance));
        });
    });
});