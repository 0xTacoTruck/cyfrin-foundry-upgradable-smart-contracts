// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.18;

import "forge-std/Test.sol";

import "src/DemoContract.sol";

contract TestContract is Test {
    DemoContract c;

    function setUp() public {
        c = new DemoContract();
    }

    function testBar() public {
        assertEq(uint256(1), uint256(1), "ok");
    }

    function testFoo(uint256 x) public {
        vm.assume(x < type(uint128).max);
        assertEq(x + x, x * 2);
    }
}
