// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BoxV1UUPSDemo} from "../src/BoxV1UUPSDemo.sol";
// Proxy standard we want to use to interact with our UUPS implementaiton contract - has constructor that takes address of implementation contract
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBox is Script {
    // Return addrress so we can actually deploy multiple box contracts and get the address each time to use
    function run() external returns (address) {
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() public returns (address) {
        vm.startBroadcast();
        BoxV1UUPSDemo box = new BoxV1UUPSDemo(); // implementation contract
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), ""); //Pass the box address to constructor for the proxy we are using
        BoxV1UUPSDemo(address(proxy)).initialize();
        vm.stopBroadcast();
        return address(proxy);
    }
}
