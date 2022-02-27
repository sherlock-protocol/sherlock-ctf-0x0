// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

contract BecomeMaster {
    
  mapping (address => uint) allocations;
  address public admin;
  address public master;
  address caller;
  
  constructor() payable {
      master = msg.sender;
  }  

  modifier onlyMaster {
	        require(
	            master == tx.origin,
	            "caller is not the master"
	        );
	        _;
	    }
  modifier onlyContract {
	        require(
	            msg.sender != tx.origin,
	            "caller is not the master"
	        );
	        _;
	    }
  modifier onlyAdmin {
	        require(
	            admin == tx.origin,
	            "caller is not the Admin"
	        );
	        _;
	    }    
  
  function allocate() public payable {
    allocations[caller] = allocations[caller] += (msg.value);
    admin = tx.origin;
  }

  function sendAllocation(address payable allocator) public {
    require(allocations[allocator] > 0);
    allocator.transfer(allocations[allocator]);
  }

  
  function takeMasterRole() public onlyAdmin onlyContract
  {
      master = admin;
  }
   
  function collectAllocations() public onlyMaster onlyContract {
    payable(msg.sender).transfer(address(this).balance);
  }

  function allocatorBalance(address allocator) public view returns (uint) {
    return allocations[allocator];
  }
 
}
