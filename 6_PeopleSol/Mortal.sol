import "./Ownable.sol";
pragma solidity 0.7.0;

contract Mortal is Ownable{
    
    event imploding(string msg);
    
    function implode() public onlyOwner {
        emit imploding('!MOOB');
        selfdestruct(owner);
    }
}