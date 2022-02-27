// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract KingVault is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    using Address for address payable;

    uint256 public constant WITHDRAWAL_LIMIT = 0.01 ether;
    uint256 public constant WAITING_PERIOD = 15 days;

    uint256 private _lastWithdrawalTimestamp;
    address private _king;

    modifier onlyKing() {
        require(msg.sender == _king, "Caller must be the king");
        _;
    }

    function initialize(
        address admin,
        address proposer,
        address king
    ) external payable initializer {
        // Initialize inheritance chain
        __Ownable_init();
        __UUPSUpgradeable_init();

        // Deploy timelock and transfer ownership to it
        transferOwnership(address(new GovernanceTimelock(admin, proposer)));

        _setKing(king);
        _setLastWithdrawal(block.timestamp);
        _lastWithdrawalTimestamp = block.timestamp;
    }

    // The governance is allow to withdraw a limited amount
    function withdraw(address payable recipient, uint256 amount)
        external
        onlyOwner
    {
        require(amount <= WITHDRAWAL_LIMIT, "Withdrawing too much");
        require(
            block.timestamp > _lastWithdrawalTimestamp + WAITING_PERIOD,
            "Try later"
        );

        _setLastWithdrawal(block.timestamp);

        recipient.sendValue(amount);
    }

    // Only the king has the power of all funds
    function withdrawAllFunds(address payable recipient) external onlyKing {
        recipient.sendValue(address(this).balance);
    }

    function getLastWithdrawalTimestamp() external view returns (uint256) {
        return _lastWithdrawalTimestamp;
    }

    function _setLastWithdrawal(uint256 timestamp) internal {
        _lastWithdrawalTimestamp = timestamp;
    }

    function _setKing(address newKing) internal {
        _king = newKing;
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {}
}

contract GovernanceTimelock is AccessControl {
    using Address for address;

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant PROPOSER_ROLE = keccak256("PROPOSER_ROLE");

    // States for an operation
    enum OperationState {
        Unknown,
        Scheduled,
        ReadyForExecution,
        Executed
    }

    // Operation data
    struct Operation {
        uint64 readyAtTimestamp; // timestamp at which the operation will be ready for execution
        bool known; // whether the operation is registered in the timelock
        bool executed; // whether the operation has been executed
    }

    // Operations are tracked by their bytes32 identifier
    mapping(bytes32 => Operation) public operations;

    uint64 public delay = 3 days;

    constructor(address admin, address proposer) {
        _setRoleAdmin(ADMIN_ROLE, ADMIN_ROLE);
        _setRoleAdmin(PROPOSER_ROLE, ADMIN_ROLE);

        // deployer + self administration
        _setupRole(ADMIN_ROLE, admin);
        _setupRole(ADMIN_ROLE, address(this));

        _setupRole(PROPOSER_ROLE, proposer);
    }

    function getOperationState(bytes32 id)
        public
        view
        returns (OperationState)
    {
        Operation memory op = operations[id];

        if (op.executed) {
            return OperationState.Executed;
        } else if (op.readyAtTimestamp >= block.timestamp) {
            return OperationState.ReadyForExecution;
        } else if (op.readyAtTimestamp > 0) {
            return OperationState.Scheduled;
        } else {
            return OperationState.Unknown;
        }
    }

    function getOperationId(
        address[] calldata targets,
        uint256[] calldata values,
        bytes[] calldata dataElements,
        bytes32 salt
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(targets, values, dataElements, salt));
    }

    function schedule(
        address[] calldata targets,
        uint256[] calldata values,
        bytes[] calldata dataElements,
        bytes32 salt
    ) external onlyRole(PROPOSER_ROLE) {
        require(targets.length > 0 && targets.length < 256);
        require(targets.length == values.length);
        require(targets.length == dataElements.length);

        bytes32 id = getOperationId(targets, values, dataElements, salt);
        require(
            getOperationState(id) == OperationState.Unknown,
            "Operation already known"
        );

        operations[id].readyAtTimestamp = uint64(block.timestamp) + delay;
        operations[id].known = true;
    }

    /** Anyone can execute what has been scheduled via `schedule` */
    function execute(
        address[] calldata targets,
        uint256[] calldata values,
        bytes[] calldata dataElements,
        bytes32 salt
    ) external payable {
        require(targets.length > 0, "Must provide at least one target");
        require(targets.length == values.length);
        require(targets.length == dataElements.length);

        bytes32 id = getOperationId(targets, values, dataElements, salt);

        for (uint8 i = 0; i < targets.length; i++) {
            targets[i].functionCallWithValue(dataElements[i], values[i]);
        }

        require(getOperationState(id) == OperationState.ReadyForExecution);
        operations[id].executed = true;
    }

    function updateDelay(uint64 newDelay) external {
        require(msg.sender == address(this), "Caller must be timelock itself");
        require(newDelay <= 14 days, "Delay must be 14 days or less");
        delay = newDelay;
    }

    receive() external payable {}
}
