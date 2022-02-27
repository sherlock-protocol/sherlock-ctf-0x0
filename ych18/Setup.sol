pragma solidity 0.8.4;

import './ISetup.sol';
import './FunnyChallenges.sol';

contract Setup is ISetup {
    FunnyChallenges public instance;

    constructor() payable {
        require(msg.value == 2 ether);

        instance = new FunnyChallenges{value: 2 ether}();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return address(instance).balance == 0;
    }
}
