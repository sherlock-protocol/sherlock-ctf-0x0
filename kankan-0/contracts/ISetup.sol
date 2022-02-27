pragma solidity 0.7.4;

interface ISetup {
    event Deployed(address instance);

    function isSolved() external view returns (bool);
}
