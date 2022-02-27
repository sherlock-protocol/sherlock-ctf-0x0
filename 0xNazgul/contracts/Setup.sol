// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
// Imports
import "./ISetup.sol";
import "./FloraToken.sol";

// Flora Token functions to use on deploy 
interface IFloraToken {
    function mint(uint256 amount) external returns (bool);
    function mintFor(address _to, uint256 _amount) external;
    function delegate(address delegatee) external;
    function approveFor(address TokenHolder, address spender, uint256 amount) external returns(bool);
}
// Deploys Flora Token and checks to see if balance == 0 to be solved
contract Setup is ISetup {
    FloraToken public instance;
 
    constructor() payable {
        require(msg.value == 1 ether);

        instance = new FloraToken{value: 1 ether}();
        emit Deployed(address(instance));

        // Amount to mint this contract
        uint256 amount; 
        // Address of contract challanger 
        address _to; 
        // Amount to mint to the challanger
        uint256 _amount;  
        // Delegates this contracts tokens to itself
        address delegatee; 
        // Delegates challenger
        address challenger;
        amount = 100;
        _to = msg.sender;
        _amount = 100;
        delegatee = address(this);
        challenger = msg.sender;

        instance.mint(amount);
        instance.mintFor(_to, _amount);
        instance.delegate(delegatee);
        instance.delegate(challenger);
    }

    // This is used as a workaround to approve your exploit contract if you need to transfer Tokens
    function approveFor(address TokenHolder, address spender, uint256 amount) external returns(bool) {
        require(TokenHolder != address(this), "You can't move this contracts tokens"); 
        instance.approveFor(TokenHolder, spender, amount);
        return(true);
    }

    function isSolved() external override view returns (bool) {
        return address(instance).balance == 0 ether;
    }
}
