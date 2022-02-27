// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import './ISetup.sol';
import './Unbreakable.sol';
import "@openzeppelin/contracts/utils/Address.sol";

contract Setup is ISetup {
    Unbreakable public instance;

    constructor() {
        instance = new Unbreakable();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return !Address.isContract(address(instance));
    }
}