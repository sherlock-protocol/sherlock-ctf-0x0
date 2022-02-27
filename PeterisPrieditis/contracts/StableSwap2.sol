// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract StableSwap2 is Ownable, ReentrancyGuard {
    uint256 public supply;
    IERC20[] public underlying;
    mapping(address => bool) public hasUnderlying;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public approvals;

    struct MintVars {
        uint256 totalSupply;
        uint256 totalBalanceNorm;
        uint256 totalInNorm;
        uint256 amountToMint;
        IERC20 token;
        uint256 has;
        uint256 preBalance;
        uint256 postBalance;
        uint256 deposited;
    }
    struct BuyBack {
        address sender;
    }

    function mint(uint256[] memory amounts)
        public
        nonReentrant
        returns (uint256)
    {
        MintVars memory v;
        v.totalSupply = supply;

        for (uint256 i = 0; i < underlying.length; i++) {
            v.token = underlying[i];

            v.preBalance = v.token.balanceOf(address(this));

            v.has = v.token.balanceOf(msg.sender);
            if (amounts[i] > v.has) amounts[i] = v.has;

            v.token.transferFrom(msg.sender, address(this), amounts[i]);

            v.postBalance = v.token.balanceOf(address(this));

            v.deposited = v.postBalance - v.preBalance;

            v.totalBalanceNorm += scaleFrom(address(v.token), v.preBalance);
            v.totalInNorm += scaleFrom(address(v.token), v.deposited);
        }
        if (v.totalSupply == 0) {
            v.amountToMint = v.totalInNorm;
        } else {
            v.amountToMint =
                (v.totalInNorm * v.totalSupply) /
                v.totalBalanceNorm;
        }
        supply += v.amountToMint;
        balances[msg.sender] += v.amountToMint;
        return v.amountToMint;
    }

    struct BurnVars {
        uint256 supply;
        uint256 haveBalance;
        uint256 sendBalance;
    }

    function burn(uint256 amount) public nonReentrant {
        require(balances[msg.sender] >= amount, "burn/low-balance");
        BurnVars memory v;
        v.supply = supply;
        for (uint256 i = 0; i < underlying.length; i++) {
            v.haveBalance = underlying[i].balanceOf(address(this));
            v.sendBalance = (v.haveBalance * amount) / v.supply;

            underlying[i].transfer(msg.sender, v.sendBalance);
        }
        supply -= amount;
        balances[msg.sender] -= amount;
    }

    function donate(uint256 amount) public nonReentrant {
        require(balances[msg.sender] >= amount, "donate/low-balance");
        require(amount > 0, "donate/zero-amount");
        BuyBack storage buyBack;
        buyBack.sender = address(msg.sender);
        supply -= amount;
        balances[buyBack.sender] -= amount;
    }

    struct SwapVars {
        uint256 preBalance;
        uint256 postBalance;
        uint256 input;
        uint256 output;
        uint256 sent;
    }

    function swap(
        address src,
        uint256 srcAmt,
        address dst
    ) public nonReentrant {
        require(hasUnderlying[src], "swap/invalid-src");
        require(hasUnderlying[dst], "swap/invalid-dst");
        SwapVars memory v;
        v.preBalance = IERC20(src).balanceOf(address(this));
        IERC20(src).transferFrom(msg.sender, address(this), srcAmt);
        v.postBalance = IERC20(src).balanceOf(address(this));
        v.input = ((v.postBalance - v.preBalance) * 997) / 1000;
        v.output = scaleTo(dst, scaleFrom(src, v.input));
        v.preBalance = IERC20(dst).balanceOf(address(this));
        IERC20(dst).transfer(msg.sender, v.output);
        v.postBalance = IERC20(dst).balanceOf(address(this));
        v.sent = (v.preBalance - v.postBalance);
        require(v.sent <= v.output, "swap/bad-token");
    }

    function scaleFrom(address token, uint256 value)
        internal
        view
        returns (uint256)
    {
        uint256 decimals = ERC20(token).decimals();
        if (decimals == 18) {
            return value;
        } else if (decimals < 18) {
            return value * 10**(18 - decimals);
        } else {
            return (value * 10**18) / 10**decimals;
        }
    }

    function scaleTo(address token, uint256 value)
        internal
        view
        returns (uint256)
    {
        uint256 decimals = ERC20(token).decimals();
        if (decimals == 18) {
            return value;
        } else if (decimals < 18) {
            return (value * 10**decimals) / 10**18;
        } else {
            return value * 10**(decimals - 18);
        }
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(balances[msg.sender] >= amount, "transfer/low-balance");
        unchecked { 
            balances[msg.sender] -= amount;
            balances[to] += amount;
        }
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        require(
            approvals[from][msg.sender] >= amount,
            "transferFrom/low-approval"
        );
        require(balances[from] >= amount, "transferFrom/low-balance");
        approvals[from][msg.sender] -= amount;
        balances[from] -= amount;
        balances[to] += amount;
        return true;
    }

    function approve(address who, uint256 amount) public returns (bool) {
        approvals[msg.sender][who] = amount;
        return true;
    }

    function totalValue() public view returns (uint256) {
        uint256 value = 0;
        for (uint256 i = 0; i < underlying.length; i++) {
            value += scaleFrom(
                address(underlying[i]),
                underlying[i].balanceOf(address(this))
            );
        }
        return value;
    }

    function addCollateral(address collateral) public onlyOwner {
        underlying.push(IERC20(collateral));
        hasUnderlying[collateral] = true;
    }
}
