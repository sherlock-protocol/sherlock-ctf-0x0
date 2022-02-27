pragma solidity 0.8.4;

import './ISetup.sol';
import './CrowdFunding.sol';

contract Setup is ISetup {
    CrowdFunding public instance;

    constructor() payable {
        require(msg.value == 1 wei);

        instance = new CrowdFunding{value: 1 wei}();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return address(instance).balance == 0;
    }
}
