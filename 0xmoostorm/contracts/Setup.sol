pragma solidity ^0.8.4;

import './ISetup.sol';
import './CollisionExchange.sol';

contract Setup is ISetup {
    CollisionExchange public exchange;
    OrderBook public orderBook;

    constructor() payable {
        require(msg.value == 1 ether);

        orderBook = new OrderBook();
        emit Deployed(address(orderBook));

        orderBook.postTrade(address(this), msg.value);

        exchange = new CollisionExchange(address(orderBook));
        emit Deployed(address(exchange));

        exchange.deposit{value: msg.value}();
    }

    function isSolved() external override view returns (bool) {
        return address(exchange).balance == 0;
    }
}