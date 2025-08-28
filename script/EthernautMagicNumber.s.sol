// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {MagicNum} from "../src/EthernautMagicNumber.sol";

contract MagicNumberSolution is Script {
    MagicNum magicNum = MagicNum(0x26DA6176f7f6c0F64eC8Bd1bBe9F78C29946De62);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // The magic bytecode that returns 42
        bytes memory creationCode = hex"69602a60005260206000f3600052600a6016f3";

        address solver;
        assembly {
            solver := create(0, add(creationCode, 0x20), mload(creationCode))
        }

        // Verify it works
        (bool success, bytes memory result) = solver.call("");
        require(success && result.length == 32, "Solver failed");
        require(abi.decode(result, (uint256)) == 42, "Wrong return value");

        magicNum.setSolver(solver);
        vm.stopBroadcast();
    }
}
