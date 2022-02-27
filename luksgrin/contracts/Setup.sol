pragma solidity 0.8.4;

import './ISetup.sol';
import './HauntedDungeon.sol';

contract Setup is ISetup {
    HauntedDungeon public instance;

    constructor() payable {
        require(msg.value == 9 ether);

        instance = new HauntedDungeon{value: 9 ether}();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return instance.treasure() == 0;
    }
}