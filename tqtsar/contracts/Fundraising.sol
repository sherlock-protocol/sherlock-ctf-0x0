// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Address.sol";

/*
  This fundraising has the following features:
    - Anyone can setup a fundraising, for themselves or for others
    - The beneficiary can be set only once
    - There's a minimum contribution set by the deployer
    - There's a target funding set by the deployer
    - You can donate in your name, or in the name of others
    - You can repent and get back your collaboration, for a fee
    - The beneficiary can withdraw the funds:
        - Anytime, if the funding goal has been met
        - 30 days from the start of the fundraising otherwise
    - Anyone can start the funding anytime
    - The beneficiary can end the funding by withdrawing the funds
*/

contract Fundraising {

    struct Collaboration {
        uint256 amount;
        uint256 timestamp;
    }

    uint256 immutable _minCollab;
    uint256 immutable _targetFunds;
    uint256 fundingEndDate;
    bool fundraisingOpened;

    address public beneficiary; 
    mapping (address => Collaboration) public collaborations;
    
   
    modifier onlyBeneficiary() {
        require (beneficiary == msg.sender, "Not the beneficiary");
        _;
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
    
    constructor (uint256 minCollab, uint256 targetFunds) {
        _minCollab = minCollab;
        _targetFunds = targetFunds;
    }

    // You can make anyone the beneficiary of your fundraising, 
    // but you can't change it once it was set
    function setBeneficiary(address newBeneficiary) public {
        // The beneficiary can only be set once
        require(beneficiary == address(0), "You can't change the beneficiary anymore");

        // Since the beneficiary needs to retrieve the funds, it can't be a contract
        bool isContract = Address.isContract(newBeneficiary);
        require(isContract == false, "The new owner is not valid.");

        beneficiary = newBeneficiary;
    }

    // You need to start the fundraising to begin receiving funds
    function startFundraising() public {
        require(beneficiary != address(0), "Set the beneficiary first");
        fundingEndDate = block.timestamp + 30 days;
        fundraisingOpened = true;
    }

    // Contribute to the fundraising with your own account
    function fund() public payable {
        require(msg.value > 0, "You have to contribute something");
        require(fundraisingOpened, "The fundraising is closed");
        require(checkAmount(msg.sender, msg.value), "You can't contribute less than minimum");

        // You can fund as many times as you want, as long it's more than the minimum
        collaborations[msg.sender].amount += msg.value;
        collaborations[msg.sender].timestamp = block.timestamp;
    }

    // Contribute to the fundraising in the name of someone else's account
    function fundAs(address donor) public payable {
        require(msg.value > 0, "You have to contribute something");
        require(fundraisingOpened, "The fundraising is closed");
        require(checkAmount(msg.sender, msg.value), "You can't contribute less than minimum");

        // You can fund for others as many times as you want, as long it's more than the minimum
        collaborations[donor].amount += msg.value;
        collaborations[donor].timestamp = block.timestamp;
    }

    function checkAmount(address user, uint256 amount) internal view returns(bool v){
        v = (collaborations[user].amount + amount >= _minCollab);
    }    


    // Withdraw your funds before the end of the fundraising. 
    // This means you no longer want to contribute anything to the beneficiary.
    // However, to prevent abuse, a penalty of 10% of your contribution will be burned.
    function repent() public {
        require(fundraisingOpened, "The fundraising is closed");
        require(collaborations[msg.sender].amount >= _minCollab, "Your collaboration is unable to be refunded");

        uint256 available = (collaborations[msg.sender].amount * 90) / 100;
        uint256 penalty = collaborations[msg.sender].amount - available;

        // To prevent new repentance, set collaboration to 0
        collaborations[msg.sender].amount = 0;
        collaborations[msg.sender].timestamp = 0;

        payable(msg.sender).transfer(available);
        payable(0x000000000000000000000000000000000000dEaD).transfer(penalty);
    }

    // Get the results of the fundraising
    function retrieveFunds() public onlyBeneficiary {
        // The beneficiary can only retrieve the funds if 30 days have passed, or if the funding target is met
        require(block.timestamp > fundingEndDate || address(this).balance >= _targetFunds, "The fundraising hasn't finished yet");

        fundraisingOpened = false;

        payable(beneficiary).transfer( address(this).balance );
    }

    // If for some weird reason an account's contribution is invalid, anyone can send the funds back to the account
    // The caller gets an incentive of 50% of the returned funds
    function refundInvalid(address user) public {
        require(collaborations[user].amount < _minCollab && collaborations[user].amount > 0, "Not an invalid amount");

        // Calculate refund and incentives
        uint256 toReturn =  collaborations[user].amount / 2;
        uint256 incentive = collaborations[user].amount - toReturn;

        // Update internal accounting
        collaborations[user].amount = 0;
        collaborations[user].timestamp = 0;
        collaborations[msg.sender].amount += incentive;
        collaborations[msg.sender].timestamp = block.timestamp;

        // Move the funds
        payable(user).transfer(toReturn);
        payable(msg.sender).transfer(incentive);
    }

    receive() external payable {
        revert();
    }
    
    fallback() external {
        revert();
    }

}
