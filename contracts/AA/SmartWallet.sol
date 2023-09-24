// // Specifies the version of Solidity, using semantic versioning.
// // Learn more: https://solidity.readthedocs.io/en/v0.5.10/layout-of-source-files.html#pragma
// pragma solidity >=0.7.3;

// import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

//simple 'wallet' for reference 

// contract SmartWallet is OwnableUpgradeable{
   
//    event UpdatedMessages(string oldStr, string newStr);
//    event NewFeeSet(uint256 newfee);
//    string public message;
//    uint256 fee;

//    constructor(string memory initMessage) {
//       message = initMessage;
//    }

//    function update(string memory newMessage) public {
//       string memory oldMsg = message;
//       message = newMessage;
//       emit UpdatedMessages(oldMsg, newMessage);
//    }

//     function getFee() external view returns (uint256) {
//         return fee;
//     }

//             //THIS WILL BE 'CREATE CONTRACT CALL' using create 2
//     function setfee2(uint256 newfee) external {
//         emit NewFeeSet(1000);
//         fee = newfee;
//     }

// }