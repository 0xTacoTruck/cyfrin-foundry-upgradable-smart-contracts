// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// THIS CONTRACT IS NEARLY IDENTICAL TO BOXV1UUPSDemo BUT IS OUR FINAL VERSION UPGRADE SO WE HAVE REMOVED SOME UPGRADEABLE LOGIC

contract BoxV2UUPSDemo is UUPSUpgradeable {
    uint256 internal number;

    function getNumber() external view returns (uint256) {
        return number;
    }

    function getVersion() external pure returns (uint256) {
        return 2;
    }

    function setNumber(uint256 _number) external {
        number = _number;
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
