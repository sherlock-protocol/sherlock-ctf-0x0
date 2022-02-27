// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;
import './ISetup.sol';
import './BecomeMaster.sol';

contract Setup is ISetup {
    BecomeMaster public instance;
    address ORIGINAL_MASTER;
 
    constructor() payable {
        require(msg.value == 0.001 ether);
        instance = new BecomeMaster{value: 0.001 ether}();
        emit Deployed(address(instance));
        ORIGINAL_MASTER = instance.master();
        instance.allocate();
    }

    function isSolved() external override view returns (bool) {
        return instance.master() != ORIGINAL_MASTER && address(instance).balance == 0;
        
    }
    
}
