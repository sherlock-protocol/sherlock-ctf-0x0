pragma solidity 0.8.4;

// Attack should be handled by EOA
// See sherlock.test.ts file for solution

contract Dummy {
    uint256 dummy;

    function dummy_function() public {
        dummy++;
    }
}