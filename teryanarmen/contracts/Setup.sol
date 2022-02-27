// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;
// fix
import "./Challenge2.sol";

interface ISetup {
    event Deployed(address challenge);

    function isSolved() external view returns (bool);
}

contract Setup is ISetup {
    Challenge2 public challenge;

    constructor() payable {
        require(msg.value == 1 ether);

        challenge = new Challenge2{value: 1 ether}();
        emit Deployed(address(challenge));
    }

    function isSolved() external view override returns (bool) {
        return address(challenge).balance == 0;
    }
}
