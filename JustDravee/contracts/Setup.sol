pragma solidity 0.8.4;

import './ISetup.sol';
import './SheerLocking.sol';

contract Setup is ISetup {
    SheerLocking public instance;

    constructor() payable {
        instance = new SheerLocking();
        emit Deployed(address(instance));
    }

    function isSolved() external override view returns (bool) {
        return SheerLocking(instance).solverIsL33t();
    }

    function attackfunction1(string calldata key1, string calldata key2, string calldata key3, string calldata key4, string calldata key5, bytes8 key6) external payable {
        instance.unSheerLock1{value: msg.value}(key1, key2, key3, key4, key5, key6);
    }

    function attackfunction2(string calldata key1, string calldata key2, string calldata key3, string calldata key4, string calldata key5, bytes8 key6) external payable {
        instance.unSheerLock2{value: msg.value}(key1, key2, key3, key4, key5, key6);
    }

    function attackfunction3(string calldata key1, string calldata key2, string calldata key3, string calldata key4, string calldata key5, bytes8 key6) external payable {
        instance.unSheerLock3{value: msg.value}(key1, key2, key3, key4, key5, key6);
    }

    function attackfunction4(string calldata key1, string calldata key2, string calldata key3, string calldata key4, string calldata key5, bytes8 key6) external payable {
        instance.unSheerLock4{value: msg.value}(key1, key2, key3, key4, key5, key6);
    }

    function attackfunction5(string calldata key1, string calldata key2, string calldata key3, string calldata key4, string calldata key5, bytes8 key6) external payable {
        instance.unSheerLock5{value: msg.value}(key1, key2, key3, key4, key5, key6);
    }

    function attackfunction6(string calldata key1, string calldata key2, string calldata key3, string calldata key4, string calldata key5, bytes8 key6) external payable {
        instance.unSheerLock6{value: msg.value}(key1, key2, key3, key5, key6);
    }

    function attackfunction7(string calldata key1, string calldata key2, string calldata key3, string calldata key4, string calldata key5, bytes8 key6) external payable {
        instance.unSheerLock7{value: msg.value}(key1, key2, key3, key4, key5, key6);
    }
}