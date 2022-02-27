pragma solidity 0.8.4;

/// @title CrowdFunding contract for sherlock-ctf
/// @notice This contract is based on the example from https://docs.soliditylang.org/en/latest/types.html#structs.
contract CrowdFunding {
    struct Funder {
        address addr;
        uint amount;
    }
    struct Campaign {
        uint numFunders;
        address owner;
        mapping (uint => Funder) funders;
    }
    uint numCampaigns;
    mapping (uint => Campaign) public campaigns;
    constructor() payable {}

    function startCampaign() payable external {
        require(msg.value == 1 wei, "Incorrect Value");
        uint campaignID = numCampaigns++; // campaignID is return variable
        Campaign storage c = campaigns[campaignID];
        c.owner = msg.sender;
        c.funders[c.numFunders++] = Funder({addr: msg.sender, amount: msg.value});
    }
    function getRefund(uint campaignID, uint funderID) external payable {
        Campaign storage c = campaigns[campaignID];
        require(msg.value == 1 wei, "Incorrect Value");
        require(c.owner != msg.sender, "Not campaign owner");
        // Refund if we already funded others
        require(c.funders[funderID].addr == msg.sender, "Not funder");
        payable(msg.sender).transfer(address(this).balance);
        delete c.funders[funderID];
    }
    function stopCampaign(uint campaignID) external payable {
        Campaign storage c = campaigns[campaignID];
        require(msg.sender == c.owner, "not owner");
        delete campaigns[campaignID];
        payable(msg.sender).transfer(1 wei);
    }
}

