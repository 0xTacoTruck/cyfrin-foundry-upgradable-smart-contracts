// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BoxV2UUPSDemo} from "../src/BoxV2UUPSDemo.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
// Proxy standard we want to use to interact with our UUPS implementaiton contract - has constructor that takes address of implementation contract
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
// NEED THE CONTRACT ABI TO UPGRADE WHICH ADDRESS THE PROXY SHOULD REDIRECT TO FOR THE NEW IMPLEMENTATION CONTRACT
import {BoxV1UUPSDemo} from "../src/BoxV1UUPSDemo.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        //Use most recently deployed box - leverage the address from latest run in foundry using the foundry devops tools
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        BoxV2UUPSDemo box = new BoxV2UUPSDemo();
        vm.stopBroadcast();

        address proxy = upgradeMyBox(mostRecentlyDeployed, address(box));
    }

    /**
     * TO UPGRADE THE ADDRESS OF THE BOX TO USE, WE NEED TO ACTUALLY USE THE ABI OF THE IMPLEMENTATION CONTRACT THAT IS BEING UPGRADED FROM
     *
     *
     */
    function upgradeMyBox(address proxyAddress, address newBox) public returns (address) {

        vm.startBroadcast();

        //Remember that this syntax forma tis just allowing us to use the ABI to get function selctor and stuff but still communicate to the proxy address
        BoxV1UUPSDemo proxy = BoxV1UUPSDemo(proxyAddress);

        // The BoxV1UUPSDemo is UUPS and has access to this function to upgrade, we could also use BoxV2 or a direct function call
        proxy.upgradeToAndCall(address(newBox), ""); // Proxy now points to new address

        vm.stopBroadcast();

        return address(proxy);
    }
}
