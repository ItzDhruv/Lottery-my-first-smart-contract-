// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract lotery{
    address public manager;             // Dhruv Dobariya
    address payable[] public participate;

        // deploy time pr j nakki thai jai ke manager je id thi deploy kryu hoi
    constructor(){              
            manager=msg.sender;        // Initilize Dhruv's account address
    }
    
    receive() external payable{
        require(msg.value== 1 ether);
        participate.push(payable(msg.sender));
    }

    function getbalance() public view returns(uint){
        require(msg.sender == manager);     // only dhruv'access
        return address(this).balance;
    }


    // for selecting random value
    function random() public view returns(uint){
    return uint(keccak256(abi.encodePacked(block.basefee, block.timestamp, participate.length)));
}

    function selectWinner() public returns(address){
        require(msg.sender == manager);         // manger is only person who can able to select winner
        require(participate.length>=3);         // 3 se jyada participate jahiye
        uint r = random();
        address payable winner;
        uint index = r%participate.length;
        winner=participate[index];
        winner.transfer(getbalance());          // transection money to winner account
        return winner;
    }
    
    }

