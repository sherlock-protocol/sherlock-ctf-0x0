pragma solidity 0.8.0;

import "./ISetup.sol";
import "./Challenge.sol";


contract Setup is ISetup {
    Challenge public instance;

    constructor() payable {
        instance = new Challenge();

        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        address govToken = instance.govTokens(0);
        return GovToken(govToken).balanceOf(address(instance)) == 0;
    }
}
