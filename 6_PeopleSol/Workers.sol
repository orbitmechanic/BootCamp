pragma solidity 0.7.0;
import "./People.sol";
// SPDX-License-Identifier: UNLICENSED

contract Workers is People {
    
    mapping(address => uint256) internal salary_;
    mapping(address => address) public boss_;
    
    event fired(address fired, address by);
    
    function createWorker(
        string memory name, 
        uint age, 
        uint height) public payable mortal costs(1 ether) {
        // Persons self-register to work.
        require(age < 75,'Cannot hire above age 75.');
        credit(msg.sender, msg.value); // Enrollment fee.
        createPerson(name, age, height, msg.sender);
        }
        
    function hire(
        address worker, 
        uint256 salary) public onlyOwner mortal {
        salary_[worker] = salary; // Boss picks salary
    }
    
    function assignBoss(
        address worker, 
        address boss) public onlyOwner mortal{
        // Company owner assigns management team.
        require(worker != boss,
            'Workers cannot supervise themselves.');
        boss_[boss] = worker;
    }
    
    function fire(address worker) public mortal {
        require(boss_[worker] == msg.sender, 
            "Only a worker's boss can fire them.");
        salary_[worker] = 0; // You're fired.
        deletePerson(worker); // You don't exist anymore.
        emit fired(worker,msg.sender);
   }
        
}