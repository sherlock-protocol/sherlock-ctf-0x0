//SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import './ISetup.sol';
import './AmusementPark.sol';

contract Setup is ISetup {
    AmusementPark public instance;

    constructor() {
        instance = new AmusementPark();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return instance.BigSmile();
    }
}