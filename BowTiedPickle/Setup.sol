pragma solidity 0.8.4;

import './ISetup.sol';
import './Padlock.sol';

contract Setup is ISetup {
    Padlock public instance;

    constructor() payable {
        string memory PIN = unicode"‮6167209‬";

        instance = new Padlock(PIN);
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        bool unlocked = instance.opened();
        return unlocked;
    }
}
