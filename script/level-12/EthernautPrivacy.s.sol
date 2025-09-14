// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {Privacy} from "../../src/level-12/EthernautPrivacy.sol";

contract PrivacySolution is Script {
    Privacy privacy = Privacy(0xce7451b278AEc172f8cBB76c51685abBd5D5f54b);
    bytes32 solution =
        0xbc9c7788058421cc930358dbd0e54e3d3d42b9c8ffe281c2298856bad435e402;

    /**
     * @notice use `cast storage` to determine flattening, denomination, awkwardness and ID variables.
     */
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        privacy.unlock(bytes16(solution));
    }
}
