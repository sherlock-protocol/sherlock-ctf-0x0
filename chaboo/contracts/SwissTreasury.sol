// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/governance/TimelockController.sol";

contract SwissTreasury is TimelockController {

  event DistributeFundsExecuted(address indexed target, uint256 value);

  constructor(uint256 minDelay, address[] memory proposers, address[] memory executors)
    payable
    TimelockController(minDelay, proposers, executors)
  {}

  function distributeFunds(address target, uint256 value) external {
    require(msg.sender == address(this), "caller must be treasury");

    (bool success, ) = target.call{value: value}("");
    require(success, "Treasury: distribute failed");

    emit DistributeFundsExecuted(target, value);
  }
}