// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@ozcontracts/proxy/ERC1967/ERC1967Proxy.sol";
import "@ozcontracts/token/ERC20/ERC20.sol";
import "./ISetup.sol";
import "./Superfluid.sol";

contract MockERC20 is ERC20("MOCK", "MOCK") {
    constructor(uint256 amount) {
        _mint(msg.sender, amount);
    }
}

contract Setup is ISetup {
    Superfluid public instance;
    address public impl;
    ERC20 public token;

    constructor() {
        impl = address(new Superfluid());
        instance = Superfluid(
            payable(
                address(
                    new ERC1967Proxy(
                        impl,
                        abi.encodeWithSignature("initialize()")
                    )
                )
            )
        );
        token = new MockERC20(20 ether);
        token.approve(address(instance), 10 ether);
        Superfluid.Timeframe memory timeFrame = Superfluid.Timeframe(
            block.number,
            block.number
        );
        instance.streamTo(address(0), token, 10 ether, timeFrame, 0);
        emit Deployed(address(instance));
    }

    function checkBalance() external view returns (uint256) {
        return instance.balanceOf(0, address(this));
    }

    function isSolved() external view override returns (bool) {
        uint256 balance;
        try Setup(this).checkBalance() returns (uint256 _balance) {
            balance = _balance;
        } catch {}
        return balance == 0;
    }
}
