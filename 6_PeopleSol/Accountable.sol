pragma solidity 0.7.0;
import './Ownable.sol';
// SPDX-License-Identifier: UNLICENSED

contract Accountable is Ownable {
    
    uint256 internal balance_;
    
    event receipt(
        address sender, 
        address reciever,
        uint256 amount);
    
    modifier costs(uint256 cost){
        require(msg.value >= cost, 'Insufficient funds sent.');
        _;
    }
    
    constructor(){
        balance_ = 0;
    }
    
    function balance() public view onlyOwner returns (uint256){
        return balance_;
    }
    
    function credit(address payable from, uint256 ammount) internal {
        balance_ += ammount;
        emit receipt(from, address(this), ammount);
    }
    
    function debt(address payable to, uint256 amount) internal {
        require(amount <= balance_, 'Insufficient funds available.');
        balance_ -= amount;
        to.transfer(amount);  // revert on fail.
        emit receipt(address(this), to, amount);
    }
    
    function salary2Owner(uint256 amount) public onlyOwner {
        debt(owner, amount);
    }
}