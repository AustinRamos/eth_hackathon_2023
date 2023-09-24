// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;


//this file contains the smart wallet 
//it is customizable to the point where any smart contract can 

//Use Create2 to know contract address before it is deployed.

import "@openzeppelin/contracts/access/Ownable.sol";


interface IERC20{
    function approve(address spender, uint256 amount) external returns (bool) ;
    function transfer(address recipient, uint256 amount) external returns (bool);
}

//make it not ownable.. 

contract SmartWallet {

   address constant public ARBITRUM_USDC=0xfd064A18f3BF249cf1f87FC203E90D8f650f2d63;
   //cello is wrapped from hyperlane warp itself
   address constant public CELLO_USDC=0xd00C86A0D83B36Be627EC7c236107F8e29CfF23E;
   
   address constant public MUMBAI_USDC=0x9999f7Fea5938fD3b1E26A12c3f2fb024e194f97 ;

    address constant public origin_relayer = 0x4fC526171b20b5D054F6Ebe3F101f8Afe74F3daB;

event SMARTWALLETCONSTRUCTOR(address owner);

    address owner;
   constructor(address _owner)  {
    emit SMARTWALLETCONSTRUCTOR(_owner);
    owner = _owner;
   }

  function transferTo(address recipient, uint256 _amount) public {
      IERC20(ARBITRUM_USDC).transfer(recipient,_amount);
  }

    //take away modifiers for debugging
   function approveTo(address _recipient,uint256 _amount) public{
       //Assuming arbitrum to cello?
        IERC20(ARBITRUM_USDC).approve(_recipient,_amount);
   }


  function executeCall(
    address target,
    bytes calldata callData,
    uint256 value
  ) external payable returns (bytes memory){
      (bool success, bytes memory data) = target.call{value: msg.value,gas: 5000}(callData); //call
      return data;
  }

function withdraw(uint _amount) external {
    require(msg.sender == owner, "caller is not owner");
    payable(msg.sender).transfer(_amount);
}

}

contract Create2Factory{
    event Deploy(address adr);

    function deploy(uint _salt) external {
        SmartWallet _contract = new SmartWallet{salt: bytes32(_salt)} (0xeC841F4BceE4EcE7B0AC562f368ee4B0cEADA0dA); 
        emit Deploy(address(_contract));
    }

    

    function getAddress(bytes memory bytecode,uint _salt)
    public 
    view 
    returns(address){
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),address(this),_salt,keccak256(bytecode)
            )
        );

        return address(uint160(uint(hash)));
    }
        //address of this factory
    function getBytecode(address _owner) public pure returns (bytes memory){
        bytes memory bytecode = type(SmartWallet).creationCode;
        return abi.encodePacked(bytecode,abi.encode(_owner));
    }
}