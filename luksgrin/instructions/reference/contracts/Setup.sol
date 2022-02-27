pragma solidity 0.8.4;

import './ISetup.sol';
import './ExampleQuizExploit.sol';

contract Setup is ISetup {
    ExampleQuizExploit public instance;

    constructor() payable {
        require(msg.value == 1 ether);

        instance = new ExampleQuizExploit{value: 1 ether}();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return address(instance).balance == 0;
    }
}