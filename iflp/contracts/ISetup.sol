pragma solidity 0.7.0;

interface ISetup {
    event Deployed(address instance);

    function isSolved() external view returns (bool);
}
