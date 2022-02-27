// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.3;

interface ICasino {
    function gameOn() external view returns (bool);

    function jackpot(uint256 num, uint256 chance) external payable;
}
