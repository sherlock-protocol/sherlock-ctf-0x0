// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.7.3;

interface ISetup {
    event Deployed(address instance);

    function isSolved() external view returns (bool);
}
