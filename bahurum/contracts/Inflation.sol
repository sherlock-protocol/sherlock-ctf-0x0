pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract InflationaryToken is Context, ERC20, Ownable {

    uint private _rate;
    bool private _goingBrr;

    constructor(string memory name_,
        string memory symbol_,
        uint rate_,
        uint initialSupply
    ) ERC20( name_, symbol_){
        _goingBrr = true;
        _rate = rate_;
        _print(initialSupply);
    }

    modifier switchPrinting() {
        _goingBrr = !_goingBrr;
        _;
    }

    modifier whenPrinting() {
        if (_goingBrr) {
            _;
        }
    }

    function _print(uint amount) internal {
        _mint(owner(), amount);
    }

    function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }

    function burnFrom(address account, uint256 amount) public virtual {
        _spendAllowance(_msgSender(), account, amount);
        _burn(account, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);
        if (totalSupply() > 0) {
            _goBrr();
        }
    }

    function _goBrr() internal whenPrinting switchPrinting {
        _print(_rate * totalSupply() / 100);
    }

    function rate() public view returns (uint) {
        return _rate;
    }

}

contract Inflation {

    InflationaryToken public token;
    string private constant name = "Inflationary Token";
    string private constant symbol = "INF";

    constructor(uint rate, uint initialSupply) { 
        token = new InflationaryToken(name, symbol, rate, initialSupply);
    }

    function isEmpty() public view returns (bool _isEmpty) {
        _isEmpty = (token.balanceOf(address(this)) == 0);
        return _isEmpty;
    }

    function tokenAddress() public view returns (address tokenAddr){
        tokenAddr = address(token);
        return tokenAddr;
    }

}