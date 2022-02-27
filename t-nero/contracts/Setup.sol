pragma solidity 0.8.7;

import "./ISetup.sol";
import "./Monopoly.sol";

contract Setup is ISetup {
    Monopoly public instance;

    constructor() payable {
        require(msg.value == 1 ether);

        instance = new Monopoly{value: 1 ether}();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return address(instance.vault()).balance == 0;
    }
}