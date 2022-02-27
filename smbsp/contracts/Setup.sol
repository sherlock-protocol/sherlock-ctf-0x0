// SPDX-License-Identifier:MIT
pragma solidity 0.8.4;

import "./ISetup.sol";
import "./CollectReward.sol";

contract Setup is ISetup {
    CollectReward public instance;

    constructor() payable {
        require(msg.value == 1 ether);

        instance = new CollectReward{value: 1 ether}();
        emit Deployed(address(instance));
    }

    function isSolved() external view override returns (bool) {
        return address(instance).balance == 0;
    }
}
