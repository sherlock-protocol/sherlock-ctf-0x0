// SPDX-License-Identifier: None
pragma solidity 0.7.2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

import "hardhat/console.sol";

/**
 * This is my first contract ever
 *
 * I tried to do a betting contract, where people could bet and try to guess on a secret number. I'm not sure I did things right though. For some reason it's not working
 *
 * I should probably have tested this before deploying
 */
contract BuiltByANoob {
    using SafeERC20 for IERC20;

    // The hidden target. They'll never ever find this. I'm so very smart (⌐■_■)
    uint256 private constant target = 71764438432;

    // Details of each bet
    struct Bet {
        uint256 amount;
        uint256 timestamp;
        IERC20 token;
    }

    // Every attempt at guessing `target` must include a bet
    // We store all of them here
    Bet[] bets;

    // Current attempt is cached here
    bytes memo;

    // How many writes spent so far
    uint8 writes;

    // the player account
    address player;

    modifier onlyPlayer(bytes32 passwordHash, bytes memory sig) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        require(sig.length == 65);

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := and(mload(add(sig, 65)), 255)
        }

        _;

        require(ecrecover(passwordHash, v, r, s) == player);
    }

    /**
     * @param passwordHash password hash to autenticate a bet
     * @param sig Signature to verify password hash
     * @param _token The token to bet with
     * @param _amount How much to bet
     * @param _initial The initial bet. On the first attempt, you can write 2 bytes for the price of one
     */
    function bet(
        bytes32 passwordHash,
        bytes memory sig,
        IERC20 _token,
        uint256 _amount,
        bytes memory _initial
    ) public onlyPlayer(passwordHash, sig) {
        require(_amount > 0, "You need to bet something. C'mon");
        require(_initial.length <= 2, "only 2 bytes at most allowed");

        Bet memory newBet;

        newBet.amount = _amount;
        newBet.timestamp = block.timestamp;
        newBet.token = _token;

        bets.push(newBet);
        _token.safeTransferFrom(msg.sender, address(this), _amount);

        writes = 1;
        memo = _initial;
    }

    /// Write a zero byte
    function write0() public {
        writes++;
        memo.push();
    }

    /// Write a filled byte
    function write255() public {
        writes++;
        memo.push(0xff);
    }

    /// Bitwise shift to the left on the current tail
    function shiftLeft(uint8 n) public {
        require(memo.length > 1, "You need to write something first");
        memo[memo.length - 1] = memo[memo.length - 1] << n;
    }

    /// Bitwise shift to the right on the current tail
    function shiftRight(uint8 n) public {
        require(memo.length > 1, "You need to write something first");
        memo[memo.length - 1] = memo[memo.length - 1] >> n;
    }

    /// Write half a byte to the current tail
    function setHalfByte(bytes1 b) public {
        memo[memo.length - 1] = (memo[memo.length - 1] & 0xf0) | (b & 0x0f);
    }

    /// Are the winning conditions met
    function won() public view returns (bool) {
        return writes >= 4 && target == _toInt();
    }

    /**
     * Utility function to convert cache to integer
     *
     * @return The computed number
     */
    function _toInt() internal view returns (uint256) {
        uint256 r;
        for (uint256 i; i < memo.length; ++i) {
            r = (r << 8) + uint8(memo[i]);
        }

        return r;
    }
}
