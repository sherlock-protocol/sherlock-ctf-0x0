// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import './ISetup.sol';
import './BitMania.sol';

contract Setup is ISetup {
    BitMania public instance;

    constructor() {

        instance = new BitMania();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return instance.isSolved();
    }
}
