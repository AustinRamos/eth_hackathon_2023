// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.13;

import "./IInterchainAccountRouter.sol";
import "./OwneeFactory.sol";
import "./OwneeFactory.sol";

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

 import "./AA/SmartWallet.sol";

//THIS IS NOW A SMART WALLET FACTORY

contract Ownee is OwnableUpgradeable {
    uint256 public fee;
    
        //test wallet is just to mimic the flow from the previous ownee/owneefactory thing.
    SmartWallet public test;
    SmartWallet[] public SmartWalletArr;
    
    constructor(address owner) {
        _transferOwnership(owner);
       test = new SmartWallet("hi");
    }

    //will trigger factory
    function setFee(uint256 newFee) onlyOwner external {
        test.setfee2(300);
        fee = test.getFee();
    }
    

   function CreateNewWallet(string memory _greeting) public {
     SmartWallet greeter = new SmartWallet(_greeting);
     SmartWalletArr.push(greeter);
   }

  //  function walletSetter(uint256 _greeterIndex, string memory _greeting) public {
  //    SmartWallet(address(SmartWalletArr[_greeterIndex])).update(_greeting);
  //  }

   function wallet_Getter(uint256 _wallet_index) public view returns (string memory) {
    return SmartWallet(address(SmartWalletArr[_wallet_index])).message();
   }
 

    //so this *is* the smart wallet factory?
    //
}
