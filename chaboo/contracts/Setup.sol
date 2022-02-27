// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import './ISetup.sol';
import './SwissTreasury.sol';

contract Setup is ISetup {
  SwissTreasury public instance;

  constructor() payable {
    require(msg.value == 1 ether);

    address[] memory proposers = new address[](0);
    address[] memory executors = new address[](1);
    executors[0] = address(0);

    instance = new SwissTreasury{value: 1 ether}(1 days, proposers, executors);

    emit Deployed(address(instance));
  }

  function isSolved() external override view returns (bool) {
    return address(instance).balance == 0;
  }
}