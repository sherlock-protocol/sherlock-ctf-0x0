// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.7.3;

import "./ISetup.sol";
import "./Casino.sol";

contract Setup is ISetup {
    Casino public casino;

    constructor() payable {
        casino = new Casino();
        emit Deployed(address(casino));
    }

    function isSolved() external view override returns (bool) {
        bool condition1 = address(casino).balance >
            casino.totalDeposits() +
                casino.totalPrize() +
                casino.totalJackpot();
        bool condition2 = address(casino).balance >
            casino.totalDeposits() +
                (casino.totalPrize() * 25) /
                100 +
                casino.totalJackpot();
        bool gameOn = casino.gameOn();

        return (gameOn && condition1) || (!gameOn && condition2);
    }
}
