pragma solidity 0.8.4;

import './ISetup.sol';
import './Challenge.sol';

contract Setup is ISetup {
    Challenge public instance;

    constructor() payable {
        require(msg.value == 100 wei);

        instance = new Challenge{value: 100 wei}();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return address(instance).balance == 0;
    }
}
