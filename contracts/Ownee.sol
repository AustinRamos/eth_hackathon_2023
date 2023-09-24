// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.13;

import "./IInterchainAccountRouter.sol";
import {SmartWallet} from "./AA/SmartWalletFactory.sol";



import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

 import "./AA/SmartWallet.sol";

interface Create2Factory {
    function deploy(uint _salt) external;

    function getAddress(bytes memory bytecode,uint _salt) external view returns(address);
        //address of this factory
        
    function getBytecode(address _owner) external pure returns (bytes memory);
}

contract Ownee is OwnableUpgradeable {
    uint256 public fee;
    address factory;
    address eoa;

        //test wallet is just to mimic the flow from the previous ownee/owneefactory thing.
    //SmartWallet public test;
    //SmartWallet[] public SmartWalletArr;
    
    constructor(address owner) {
        _transferOwnership(owner);

        factory = 0x7CDFcE52EF7b16D2089f9bA7c5aE2d22D4E7A1d0;
        
        //hardcoded new_fresh_nonce which owns the 
        eoa = 0xeC841F4BceE4EcE7B0AC562f368ee4B0cEADA0dA;
       

    }

    //will trigger Create smart wallet. name is kept as setFee for simplicity because of function hash on owner side 
    function setFee(uint256 newFee) onlyOwner external {

        bytes memory byte_code = Create2Factory(factory).getBytecode(eoa);

        address determined_address = Create2Factory(factory).getAddress(byte_code,42);
       //this should deploy the smart wallet on celo at same address as origin wallet on 
       
       Create2Factory(factory).deploy(42);
    }
    

//    function CreateNewWallet(string memory _greeting) public {
//      SmartWallet greeter = new SmartWallet(_greeting);
//      SmartWalletArr.push(greeter);
//    }

  //  function walletSetter(uint256 _greeterIndex, string memory _greeting) public {
  //    SmartWallet(address(SmartWalletArr[_greeterIndex])).update(_greeting);
  //  }

//    function wallet_Getter(uint256 _wallet_index) public view returns (string memory) {
//     return SmartWallet(address(SmartWalletArr[_wallet_index])).message();
//    }
 

    //so this *is* the smart wallet factory?
    //
}
