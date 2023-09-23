//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./SmartWallet.sol";


//*****this is now being integrated with Ownee.sol */

contract SmartWalletFactory {
   SmartWallet[] public SmartWalletArr;

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
}