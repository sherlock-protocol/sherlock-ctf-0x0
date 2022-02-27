// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
import "./ISetup.sol";
import "./StableSwap2.sol";
import {ERC20PresetFixedSupply} from "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetFixedSupply.sol";

contract Setup is ISetup {
    StableSwap2 public instance;
    ERC20PresetFixedSupply public USDC;
    ERC20PresetFixedSupply public USDT;
    ERC20PresetFixedSupply public BUSD;

    constructor() payable {
        require(msg.value == 0.0000374 ether);
        USDC = new ERC20PresetFixedSupply("USDC Stablecoin","USDC",11000,address(this));
        USDT = new ERC20PresetFixedSupply("USDT Stablecoin","USDT",10000,address(this));
        BUSD = new ERC20PresetFixedSupply("BUSD Stablecoin","BUSD",10000,address(this));
        instance = new StableSwap2();
        instance.addCollateral(address(USDC));
        instance.addCollateral(address(USDT));
        instance.addCollateral(address(BUSD));
        USDC.approve(address(instance), 100000);
        USDT.approve(address(instance), 100000);
        BUSD.approve(address(instance), 100000);
        uint256[] memory amounts = new uint256[](3);
        amounts[0] = USDC.balanceOf(address(this)) - 1000;
        amounts[1] = USDT.balanceOf(address(this));
        amounts[2] = BUSD.balanceOf(address(this));
        instance.mint(amounts);
        emit Deployed(address(instance));
    }

    function isSolved() external view override returns (bool) {
        uint256 totalValue = USDC.balanceOf(address(instance));
        totalValue = USDT.balanceOf(address(instance));
        totalValue = BUSD.balanceOf(address(instance));
        return totalValue < 100;
    }

    function faucet(uint256 amount) public {
        USDC.transfer(msg.sender, amount);
    }
}
