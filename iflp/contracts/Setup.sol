pragma solidity 0.7.0;

import "./ISetup.sol";
import "./ExampleQuizExploit.sol";

contract Setup is ISetup {
    ExampleQuizExploit public instance;
    Lollercoaster public rng;
    bool private isInitialized = false;

    constructor() payable {
        require(msg.value == 1 ether);
        instance = new ExampleQuizExploit{value: 1 ether}();
        emit Deployed(address(instance));
    }

    function isSolved() external view override returns (bool) {
        return address(instance).balance == 0;
    }
}
