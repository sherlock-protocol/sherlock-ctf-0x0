pragma solidity 0.8.9;

interface ISetup {
    event Deployed(address instance);

    function isSolved() external view returns (bool);
}
