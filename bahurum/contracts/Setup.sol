pragma solidity 0.8.4;

import './ISetup.sol';
import './Inflation.sol';

contract Setup is ISetup {
    
    Inflation public instance;
    uint public constant inflationRate = 10;
    uint public constant initialSupply = 1000;

    constructor() {
        instance = new Inflation(inflationRate, initialSupply);
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return instance.isEmpty();
    }
}