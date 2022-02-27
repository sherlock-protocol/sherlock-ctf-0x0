// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ISetup.sol";
import "./Challenge.sol";

contract Setup is ISetup {
    Challenge public instance;

    constructor() payable {
        require(msg.value == 1 ether);
        Slogan slogan = new Slogan();
        SloganProxy sloganProxy = new SloganProxy();
        sloganProxy.initialize(address(slogan), "");
        instance = new Challenge{value: 1 ether}(address(sloganProxy));
        emit Deployed(address(instance));
    }

    function isSolved() external view override returns (bool) {
        return address(instance).balance == 0;
    }
}
