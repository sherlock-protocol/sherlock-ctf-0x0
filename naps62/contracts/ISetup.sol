// SPDX-License-Identifier: None
pragma solidity 0.7.2;

interface ISetup {
    event Deployed(address instance);

    function isSolved() external view returns (bool);
}
