// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Casino {
    // address public owner;
    uint public count = 0;

    struct Contact {
        uint id;
        string name;
        string phone;
    }

    mapping(uint => Contact) contacts;

    constructor() public {
        
        // owner = msg.sender;        
        createContact("Reyhane", "091523543821");
        
    }
    // modifier onlyOwner() {
    //     require(msg.sender == owner);
    //     _;
    // }

    function createContact(string memory name_, string memory phone_) public {
        unchecked {
            count++;
        }
        contacts[count]=Contact(count,name_,phone_);
        
    }

    // function getContactphone(uint id)  public view returns(string memory){
    //     return contacts[id].phone;
    // }

    // function getContactName(uint id) public view returns(string memory) {
    //     return  contacts[id].name;
    // }

    // function setOwner() public  {
    //     owner = msg.sender;
    // }

    // function get_owner() public view returns(address) {
    //     require(msg.sender == owner);
    //     return owner;
    // }

    // function add_Owner () public returns(uint) {
    //     return count++;
    // }




}