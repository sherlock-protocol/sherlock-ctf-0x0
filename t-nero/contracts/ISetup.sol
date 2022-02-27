pragma solidity 0.8.7;

interface ISetup {
    event Deployed(address instance);

    function isSolved() external view returns (bool);
}