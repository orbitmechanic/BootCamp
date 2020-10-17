pragma solidity 0.7.0;
import './Ownable.sol';
import './Safemath.sol';

// SPDX-License-Identifier: UNLICENSED

contract ERC20 is Ownable {

    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

        constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _decimals = 18;
    }


    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function mint(address account, uint256 amount) public onlyOwner {
        // tokenomics: Owner go brrrr
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount); 
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(_balances[msg.sender] >= amount,'Insufficient funds available.');
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        return true; // per spec.
    }
}
