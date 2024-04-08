// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
//import {StdInvariant} from "forge-std/StdInvariant.sol";
import {console} from "forge-std/console.sol";
import {BoxV1UUPSDemo} from "../../src/BoxV1UUPSDemo.sol";
import {DeployBox} from "../../script/DeployBox.s.sol";
import {UpgradeBox} from "../../script/UpgradeBox.s.sol";
import {BoxV2UUPSDemo} from "../../src/BoxV2UUPSDemo.sol";

contract DeployAndUpgradeBoxTest is Test {
    DeployBox public deployBox;
    UpgradeBox public upgradeBox;
    address public OWNER = makeAddr("owner");
    address public proxy;
    BoxV1UUPSDemo boxV1;
    BoxV2UUPSDemo boxV2;

    function setUp() public {
        
        //vm.startBroadcast();
        deployBox = new DeployBox();
        upgradeBox = new UpgradeBox();
        proxy = deployBox.run(); // Right now points to boxV1
        //vm.stopBroadcast();
    }


    function test_Upgrades() public{
        //vm.startBroadcast();
        boxV2 = new BoxV2UUPSDemo();

        //Pass actual deployed implementation contract address
        upgradeBox.upgradeMyBox(proxy, address(boxV2));

        uint256 expectedVersion = 2;
        //Remember that this syntax forma tis just allowing us to use the ABI to get function selctor and stuff but still communicate to the proxy address
        assertEq(BoxV2UUPSDemo(proxy).getVersion(), expectedVersion);


        // Change the number that is stored for the variable, which is in the proxy contract storage slots
        BoxV2UUPSDemo(proxy).setNumber(5);

        uint256 expectedNum = 5;

        assertEq(BoxV2UUPSDemo(proxy).getNumber(), expectedNum);

        //vm.stopBroadcast();
    }


    function test_ProxyStartsAsV1() public {
       //vm.startBroadcast();
       vm.expectRevert();
       // Our implementation contract after set up is V1 and therefore this should revert because V1 does not have the setNumber() function
       BoxV2UUPSDemo(proxy).setNumber(77);
       //vm.stopBroadcast();
    }

}