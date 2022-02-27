// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

interface ISetup {
    event Deployed(address instance);

    function isSolved() external view returns (bool);
}
