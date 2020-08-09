pragma solidity 0.7.0;
import "./Accountable.sol";
// SPDX-License-Identifier: UNLICENSED

contract Mortal is Accountable{
    
    event transcend(string msg);

    bool private alive_;

    constructor() {
        alive_ = true;
    }

    modifier mortal() {
        require(alive_,'Contract inputs are locked.');
        _;
    }
    
    modifier undead() {
        require(alive_ == false,
            'Function only valid if contract inputs are locked.');
        _;
    }
    
    modifier immortal(){
        _;
    }
    
    function pause() public onlyOwner mortal {
        alive_ = false;
        emit transcend('Input locked.');
    }
    
    function kill() public onlyOwner mortal {
        salary2Owner(balance_);
        pause();
    } 
    
    function doubleTap() public onlyOwner undead{
        emit transcend('Contract R.I.P.');
        selfdestruct(owner);
    }

    function ressurect() public onlyOwner undead {
        alive_ = true;
        emit transcend('Input unlocked.');
    }
    
    function unpause() public onlyOwner undead{
        ressurect();
    }

    function living() public view returns (bool) {
        return alive_;
    }
    
}