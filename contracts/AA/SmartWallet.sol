// Specifies the version of Solidity, using semantic versioning.
// Learn more: https://solidity.readthedocs.io/en/v0.5.10/layout-of-source-files.html#pragma
pragma solidity >=0.7.3;

// A contract is a collection of functions and data (its state). Once deployed, a contract resides at a specific address on the Ethereum blockchain. Learn more: https://solidity.readthedocs.io/en/v0.5.10/structure-of-a-contract.html
contract SmartWallet {


   //this is basically what OwnerFactory was previously, actually an instance of a wallet, 
   //created by ownee.sol which is a factory 
   
   event UpdatedMessages(string oldStr, string newStr);
   event NewFeeSet(uint256 newfee);
   string public message;
   uint256 fee;

   constructor(string memory initMessage) {
      message = initMessage;
   }

   function update(string memory newMessage) public {
      string memory oldMsg = message;
      message = newMessage;
      emit UpdatedMessages(oldMsg, newMessage);
   }

    function getFee() external view returns (uint256) {
        return fee;
    }

    function setfee2(uint256 newfee) external {
        emit NewFeeSet(1000);
        fee = newfee;
    }

}