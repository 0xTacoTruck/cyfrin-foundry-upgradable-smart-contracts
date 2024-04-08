// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV1UUPSDemo is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    // Our proxy can stop any initialising from happening
    constructor() {
        _disableInitializers();
    }

    // Our proxy won't have a constructor so we have an initialiser function in the implementation contract that can be called
    // After deploying contract, we immediately have our proxy call this function to initialise what we need to so the proxy has the storage not the implementation
    // We also also the initializer modifier from Initializable - We should only be able to initialise ONCE and this modifier allows this
    function initialize() public initializer {
        // Often these initialise function that call other functions inside of here, or other logic, use double-underscores before the naming of the function
        __Ownable_init(msg.sender); // Function of OwnableUpgradeable that will transfer ownership to msg.sender
        __UUPSUpgradeable_init(); // Does nothing but does have modifier to check if intialisation is occurring - this is best practise to highlight what type of contract this is
    }

    function getNumber() public view returns (uint256) {
        return number;
    }

    function getVersion() public view returns (uint256) {
        return 1;
    }

    // UUPSUpgradeable is an abstract so we need to override functions that are specified in it
    // Could also add only owner modifier and you shopuld, but for demo purposes we will skip it
    function _authorizeUpgrade(address newImplementation) internal override {
        // This is where we would have CEI design for things like, not admin, authorise upgrade, etc
        // NOT SO RELEVANT FOR THIS DEMO
        /*
            if (msg.sender != admin) {
                revert();
            }
            */
    }
}
