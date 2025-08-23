// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {
    // Implementation contract
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    // Proxy contract
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) {
        delegate = Delegate(_delegateAddress); // Perlu deploy Delegate contract dulu sebelum deploy Delegation contract
        owner = msg
            .sender; /* Owner contract Delegate dan Delegation adalah 0xe04f955e4Cf9858F8f8d60C09aBf16DF23D4672b. Use `cast storage 0x9d1EbDcDDa938AAf3A495c7DF02191ffa46e80C8 0 --rpc-ur
l sepolia --etherscan-api-key ${ETHERSCAN_API}` lalu cast parse-bytes32-address 0x000000000000000000000000e04f955e4cf98
58f8f8d60c09abf16df23d4672b*/
    }

    fallback() external {
        (bool result, ) = address(delegate).delegatecall(msg.data);
        if (result) {
            this;
        }
    }
}
