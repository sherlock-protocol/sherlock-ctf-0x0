// Challenge name: Counterfactual
// Author: Throttle (@_no_handlebars)


pragma solidity 0.8.4;

import "./Factory.sol";
import "./Challenge.sol";

contract Setup {
    event Deployed(address);

    Factory public factory;
    Challenge public challenge;

    constructor() {
        factory = new Factory();
        challenge = new Challenge(address(factory));
        emit Deployed(address(challenge));
    }

    function isSolved() external view returns (bool) {
        return challenge.isSolved();
    }
}
