// SPDX-License-Identifier: MIT
pragma solidity >=0.7.3;

interface ISmartWalletFactory {

  function getSmartWallet(
    address
  ) external returns (address);

}

