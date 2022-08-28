// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Casino_origin {
    address public owner;

    // mapping(uint32 => uint256) private player;
    struct player {
        uint256 numberselected;
        uint256 amountBet;
    }

    mapping(address => player) player_info;
    address[] public players;  
    uint256 minumBet;
    uint256 totalBet;
    uint256 numberofBets;
    uint256 MaxnumberofBets = 100;


    constructor(uint256 minumBet_) {
        owner = msg.sender;
        if (minumBet_ != 0)   minumBet = minumBet_;
    }

    function bet(uint256 number) public payable{
        require(msg.sender == owner);
        require(!checkPlayerExist(owner));
        require(number >=1 && number <= 10);
        require(msg.value > minumBet);
        player_info[owner].amountBet = msg.value;
        player_info[owner].numberselected = number;
        numberofBets++;
        players.push(owner);
        totalBet += msg.value;
        if (numberofBets >= MaxnumberofBets) generateNumberWiner();
    }

    function generateNumberWiner() private {
        uint256 random_number =  uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players))) % 10 +1;
        distributePrice(random_number);
    }

    function distributePrice(uint win_number) public {
        
        require(msg.sender == owner); 
        address payable [100]  memory winners;
        uint count= 0;

        for(uint i=0; i < players.length; i++) {
            address user = players[i];
            if (player_info[user].numberselected == win_number) {
                winners[count] = payable(user);
                count++;
            }
            delete player_info[user];
        }
        delete players;
        uint winnerEtherAmount = totalBet / winners.length;
        for(uint i = 0 ; i < winners.length; i++) {
            if (winners[i] != address(0))
                winners[i].transfer(winnerEtherAmount);
        }
        resetData();
    }

    function checkPlayerExist(address user) public view returns(bool) {
        for(uint i=0; i < players.length; i++) 
            if (players[i] == user)
                return true;
        return false;
    }

    function resetData() public {
        // players.length = 0;
        totalBet = 0;
        numberofBets = 0;
    }

    function kill() public {
        if (msg.sender == owner)
        selfdestruct(payable(owner));
    }
}

