//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/Test.sol";

contract DemoScript is Script {
    function run() external {
      console.log("This can be useful to set up!");
  }
}
