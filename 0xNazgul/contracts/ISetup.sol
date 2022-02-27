// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

interface ISetup {
    event Deployed(address instance);

    function isSolved() external view returns (bool);
}
