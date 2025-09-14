// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract King {
    address king; // 0x473c8dF98DFd41304Bff2c5945B9f73e30f5c013 (Utilize cast storage to know)
    uint256 public prize; // 0.001 ETH
    address public owner; // 0x473c8dF98DFd41304Bff2c5945B9f73e30f5c013

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}
