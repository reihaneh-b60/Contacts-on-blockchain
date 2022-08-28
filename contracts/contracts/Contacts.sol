// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

contract Contacts {
  address owner= msg.sender;
  uint public count = 0; // state variable

  struct Contact {
		uint id;
		string name;
		string phone;
	}

	constructor() public {
		createContact('Reyhaneh', '09163452382');
	}

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

	mapping(uint => Contact) public contacts;

	function createContact(string memory _name, string memory _phone) public onlyOwner returns(uint){
		bool flag = false;
		for(uint i=0; i <= count; i++) {
			if (keccak256(abi.encodePacked(contacts[i].name)) == keccak256(abi.encodePacked(_name)) &&
					 keccak256(abi.encodePacked(contacts[i].phone)) == keccak256(abi.encodePacked(_phone)))
				flag= true;
		}
		if (!flag) {
			count++;
			contacts[count] = Contact(count, _name, _phone);
			return count;
		}
		return 0;
		
	}
	function delContact(uint index) public  onlyOwner{
		if (index <= count) {
       		 delete contacts[index];
		}

	}

	function delList() public onlyOwner {
		for (uint i=1; i<= count;i++) 
			delete contacts[i];
		count=0;

	}

	// function delContact(uint index) public  {
	// 	if (index >= count) return;
	// for (uint i = index; i< count; i++){
    //         contacts[i] = contacts[i+1];
    //     }
    //     delete contacts[count];
    //     count = count - 1;

	// }

	}