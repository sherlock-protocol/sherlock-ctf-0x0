// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;
// fix
import "@openzeppelin/contracts/utils/Address.sol";

interface ICalled {
    function sup() external returns (uint256);
}

contract Challenge2 {
    using Address for address;

    State public state;
    address public winner;

    modifier onlyWinner() {
        require(msg.sender == winner, "oops");
        _;
    }
    modifier onlyState(State _state) {
        require(state == _state, "no...");
        _;
    }
    modifier onlyContract() {
        require(Address.isContract(msg.sender), "try again");
        _;
    }
    modifier onlyNotContract() {
        require(!Address.isContract(msg.sender), "yeah, no");
        _;
    }

    enum State {
        THREE,
        TWO,
        ONE,
        ZERO
    }

    constructor() payable {
        require(msg.value == 1 ether, "cheap");
    }

    function first() public onlyWinner onlyNotContract onlyState(State.ONE) {
        state = State.ZERO;
    }
    
    function second() public onlyWinner onlyContract onlyState(State.TWO) {
    require(ICalled(msg.sender).sup() == 1337, "not leet");
        state = State.ONE;
    }

    function third() public onlyNotContract onlyState(State.THREE) {
        winner = msg.sender;
        state = State.TWO;
    }

    function fourth() public onlyWinner onlyContract onlyState(State.ZERO) {
        require(ICalled(msg.sender).sup() == 80085, "not boobs");
        msg.sender.transfer(address(this).balance);
    }
}