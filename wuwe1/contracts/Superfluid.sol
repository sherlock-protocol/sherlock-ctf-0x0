// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "@ozcontracts/token/ERC20/ERC20.sol";
import "@ozupgrade/access/OwnableUpgradeable.sol";
import "@ozupgrade/proxy/utils/Initializable.sol";
import "@ozupgrade/proxy/utils/UUPSUpgradeable.sol";

contract Superfluid is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    error Unauthorized();
    error StreamNotFound();
    error StreamStillActive();

    struct Stream {
        address sender;
        address recipient;
        ERC20 token;
        uint256 balance;
        uint256 withdrawnBalance;
        uint256 paymentPerBlock;
        Timeframe timeframe;
    }
    struct Timeframe {
        uint256 startBlock;
        uint256 stopBlock;
    }
    struct Signature {
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    uint256 internal streamId;
    uint256 public nonce;
    bytes32 public immutable domainSeparator;
    bytes32 public constant UPDATE_DETAILS_HASH =
        keccak256(
            "UpdateStreamDetails(uint256 streamId,uint256 paymentPerBlock,uint256 startBlock,uint256 stopBlock,uint256 nonce)"
        );
    mapping(uint256 => Stream) public getStream;

    constructor() {
        domainSeparator = keccak256(
            abi.encode(
                keccak256(
                    "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
                ),
                keccak256(bytes("Superfluid")),
                keccak256(bytes("1")),
                block.chainid,
                address(this)
            )
        );
    }

    function initialize() public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function streamTo(
        address recipient,
        ERC20 token,
        uint256 initialBalance,
        Timeframe memory timeframe,
        uint256 paymentPerBlock
    ) external payable returns (uint256) {
        Stream memory stream = Stream({
            token: token,
            sender: msg.sender,
            withdrawnBalance: 0,
            timeframe: timeframe,
            recipient: recipient,
            balance: initialBalance,
            paymentPerBlock: paymentPerBlock
        });

        getStream[streamId] = stream;

        token.transferFrom(msg.sender, address(this), initialBalance);

        return streamId++;
    }

    function refuel(uint256 id, uint256 amount) public payable {
        if (getStream[id].sender != msg.sender) revert Unauthorized();

        unchecked {
            getStream[id].balance += amount;
        }

        getStream[id].token.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 id) public payable {
        if (getStream[id].recipient != msg.sender) revert Unauthorized();

        uint256 balance = balanceOf(id, msg.sender);

        unchecked {
            getStream[id].withdrawnBalance += balance;
        }

        getStream[id].token.transfer(msg.sender, balance);
    }

    function refund(uint256 id) public payable {
        if (getStream[id].sender != msg.sender) revert Unauthorized();
        if (getStream[id].timeframe.stopBlock > block.number)
            revert StreamStillActive();

        uint256 balance = balanceOf(id, msg.sender);

        getStream[id].balance -= balance;

        getStream[id].token.transfer(msg.sender, balance);
    }

    function calculateBlockDelta(Timeframe memory timeframe)
        internal
        view
        returns (uint256 delta)
    {
        if (block.number <= timeframe.startBlock) return 0;
        if (block.number < timeframe.stopBlock)
            return block.number - timeframe.startBlock;

        return timeframe.stopBlock - timeframe.startBlock;
    }

    function balanceOf(uint256 id, address who) public view returns (uint256) {
        Stream memory stream = getStream[id];

        if (stream.sender == address(0)) revert StreamNotFound();

        uint256 blockDelta = calculateBlockDelta(stream.timeframe);
        uint256 recipientBalance = blockDelta * stream.paymentPerBlock;

        if (who == stream.recipient)
            return recipientBalance - stream.withdrawnBalance;
        if (who == stream.sender) return stream.balance - recipientBalance;

        return 0;
    }

    function updateDetails(
        uint256 id,
        uint256 paymentPerBlock,
        Timeframe memory timeframe,
        Signature memory sig
    ) public payable {
        Stream memory stream = getStream[id];

        if (stream.sender == address(0)) revert StreamNotFound();

        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                domainSeparator,
                keccak256(
                    abi.encode(
                        UPDATE_DETAILS_HASH,
                        id,
                        paymentPerBlock,
                        timeframe.startBlock,
                        timeframe.stopBlock,
                        nonce++
                    )
                )
            )
        );

        address sigAddress = ecrecover(digest, sig.v, sig.r, sig.s);

        if (
            !(stream.sender == msg.sender && stream.recipient == sigAddress) &&
            !(stream.sender == sigAddress && stream.recipient == msg.sender)
        ) revert Unauthorized();

        getStream[id].paymentPerBlock = paymentPerBlock;
        getStream[id].timeframe = timeframe;
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {}

    receive() external payable {}
}
