// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;
import './Ownable.sol';

contract ERC20 is Ownable {

    mapping (address => uint256) private _balances;

    uint256 private _totalSupply;

    string private _name = 'CryptAnimal';
    string private _symbol = 'CA';
    uint8 private _decimals = 18;

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
        _totalSupply += amount;
        _balances[account] += amount; 
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(_balances[msg.sender] >= amount,'Insufficient funds available.');
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        return true; // per spec.
    }
}
