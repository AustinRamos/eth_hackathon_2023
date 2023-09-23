// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.13;

import "./IInterchainAccountRouter.sol";
import "./OwneeFactory.sol";

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Ownee is OwnableUpgradeable {
    uint256 public fee;
    OwneeFactory public owneeFactory;
    constructor(address owner) {
        _transferOwnership(owner);
        owneeFactory = new OwneeFactory();
    }

    //will trigger factory
    function setFee(uint256 newFee) onlyOwner external {
        owneeFactory.setfee2(300);
        fee = owneeFactory.getFee();
    }
}
