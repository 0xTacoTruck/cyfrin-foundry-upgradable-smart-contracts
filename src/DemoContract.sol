// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.18;

contract DemoContract { 
    uint256 a = 1;
    uint256 b = 9;
    uint256 result;

    function calculate() public {
        result = a + b;
    }

}
