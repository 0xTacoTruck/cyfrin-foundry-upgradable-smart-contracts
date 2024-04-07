// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

//This is a proxy contract that we can leverage to get started on using delegatecall and learn mroe about this topic
import "@openzeppelin/contracts/proxy/Proxy.sol";

/**
 * @notice this example contract uses Yul or in-line assembly that we have not covered yet, the focus of this lesson is upgradable contracts and delegatecall
 * - and so we wont get bogged down in the details here of it except when needed
 */
contract SmallProxy is Proxy {
    // This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1
    bytes32 private constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    // We want to be able to update the contract address of the implementation contract for this proxy
    function setImplementation(address newImplementation) public {
        assembly {
            sstore(_IMPLEMENTATION_SLOT, newImplementation)
        }
    }

    // The way our proxy is going to work is whenever this contract is called and its not the 'setImplementation' contract, we are going to load the contract address -
    // - from the standardised storage slot of ERC1967 and then use that for delegatecall
    function _implementation() internal view override returns (address implementationAddress) {
        assembly {
            implementationAddress := sload(_IMPLEMENTATION_SLOT)
        }
    }

    // helper function for demo purposes so we can call our proxy in Remix and play around
    function getDataToTransact(uint256 numberToUpdate) public pure returns (bytes memory) {
        return abi.encodeWithSignature("setValue(uint256)", numberToUpdate);
    }

    function readStorage() public view returns (uint256 valueAtStorageSlotZero) {
        assembly {
            valueAtStorageSlotZero := sload(0)
        }
    }
}

contract ImplementationA {
    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue;
    }
}

contract ImplementationB {
    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue + 2;
    }
}

// function setImplementation(){}
// Transparent Proxy -> Ok, only admins can call functions on the proxy
// anyone else ALWAYS gets sent to the fallback contract.

// UUPS -> Where all upgrade logic is in the implementation contract, and
// you can't have 2 functions with the same function selector.
