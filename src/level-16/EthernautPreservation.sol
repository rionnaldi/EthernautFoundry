// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Preservation {
    // public library contracts
    address public timeZone1Library; // 0x0000000000000000000000005cc07efbbfa39dfb02d4abae21791d43eb6cedcf -> 0x5cC07EfBbFa39dfB02D4Abae21791D43eb6CEDcF
    address public timeZone2Library; // 0x0000000000000000000000007cf753cb68dc00bb295de66a391c04d808e90d13 -> 0x7CF753cb68DC00bb295dE66a391C04D808E90D13
    address public owner; // 0x00000000000000000000000035b28cb86846382aa6217283f12c13657ff0110b -> 0x35b28CB86846382Aa6217283F12C13657FF0110B
    uint256 storedTime;
    // Sets the function signature for delegatecall
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    constructor(
        address _timeZone1LibraryAddress,
        address _timeZone2LibraryAddress
    ) {
        timeZone1Library = _timeZone1LibraryAddress;
        timeZone2Library = _timeZone2LibraryAddress;
        owner = msg.sender;
    }

    // set the time for timezone 1
    function setFirstTime(uint256 _timeStamp) public {
        timeZone1Library.delegatecall(
            abi.encodePacked(setTimeSignature, _timeStamp)
        );
    }

    // set the time for timezone 2
    function setSecondTime(uint256 _timeStamp) public {
        timeZone2Library.delegatecall(
            abi.encodePacked(setTimeSignature, _timeStamp)
        );
    }
}

// Simple library contract to set the time
contract LibraryContract {
    // Should use library instead of contract, library is stateless. It avoids storage collision when doing delegatecall
    // stores a timestamp
    uint256 storedTime;

    function setTime(uint256 _time) public {
        storedTime = _time;
    }
}
