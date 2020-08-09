pragma solidity 0.7.0;
import './Mortal.sol';
// SPDX-License-Identifier: UNLICENSED

contract People is Mortal {

    struct Person {
      uint id;
      string name;
      uint age;
      uint height;
      bool senior;
    }

    event personCreated(string name, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);

    mapping (address => Person) internal people;
    address[] internal creators;

    function createPerson(string memory name, uint age, uint height, address sender) internal mortal {
        require(age < 150, "Age needs to be below 150");
        

        //This creates a person
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;

        if(age >= 65){
           newPerson.senior = true;
        }
        else{
           newPerson.senior = false;
        }

        insertPerson(newPerson);
        creators.push(sender);

        assert(
            keccak256(
                abi.encodePacked(
                    people[sender].name,
                    people[sender].age,
                    people[sender].height,
                    people[sender].senior
                )
            )
            ==
            keccak256(
                abi.encodePacked(
                    newPerson.name,
                    newPerson.age,
                    newPerson.height,
                    newPerson.senior
                )
            )
        );
        emit personCreated(newPerson.name, newPerson.senior);
    }
    
    function insertPerson(Person memory newPerson) internal {
        address creator = msg.sender;
        people[creator] = newPerson;
    }
    
    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
        address creator = msg.sender;
        return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }
    
    function deletePerson(address person) internal mortal {
       string memory name = people[person].name;
       bool senior = people[person].senior;
       delete people[person];
       assert(people[person].age == 0);
       emit personDeleted(name, senior, owner);
   }

}