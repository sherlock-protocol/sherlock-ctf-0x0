pragma solidity 0.8.9;

import './ISetup.sol';
import './Fundraising.sol';

contract Setup is ISetup {
    Fundraising public instance;

    constructor() payable {
        require(msg.value == 1000 gwei);

        instance = new Fundraising(1000 gwei, 1 ether);
        instance.setBeneficiary(msg.sender);
        instance.startFundraising();
        instance.fund{value:msg.value}();
        
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return address(instance).balance == 0;
    }
}
