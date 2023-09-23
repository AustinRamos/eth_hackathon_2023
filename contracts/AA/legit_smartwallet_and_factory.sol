//SPDX-License-Identifier: MIT

pragma solidity >=0.7.3;
pragma experimental ABIEncoderV2;



import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
//import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/utils/Pausable.sol";

//import { Decimal } from "./utils/Decimal.sol";
// import { SignedDecimal } from "./utils/SignedDecimal.sol";
// import { DecimalERC20 } from "./utils/DecimalERC20.sol";

// import { IAmm } from "./interface/IAmm.sol";
// import { IClearingHouse } from "./interface/IClearingHouse.sol";
import { ISmartWallet } from "./ISmartWallet.sol";
import {ISmartWalletFactory} from "./ISmartWalletFactory.sol";


//took out Pausable.. 

contract SmartWallet is  Initializable, ISmartWallet {

  // Store addresses of smart contracts that we will be interacting with
  //LimitOrderBook public OrderBook;
  SmartWalletFactory public factory;
  address constant CLEARINGHOUSE = 0x5d9593586b4B5edBd23E7Eba8d88FD8F09D83EBd;

  address private owner;

//   using Decimal for Decimal.decimal;
//   using SignedDecimal for SignedDecimal.signedDecimal;
  using Address for address;
  //using SafeERC20 for IERC20;

  /*
   * @notice allows the owner of the smart wallet to execute any transaction
   *  on an external smart contract. The external smart contract must be whitelisted
   *  otherwise this function will revert
   *  This utilises functions from OpenZeppelin's Address.sol
   * @param target the address of the smart contract to interact with (will revert
   *    if this is not a valid smart contract)
   * @param callData the data bytes of the function and parameters to execute
   *    Can use encodeFunctionData() from ethers.js
   * @param value the ether value to attach to the function call (can be 0)
   */

  function executeCall(
    address target,
    bytes calldata callData,
    uint256 value
  ) external payable override onlyOwner() returns (bytes memory) {
    require(target.isContract(), 'call to non-contract');
    require(factory.isWhitelisted(target), 'Invalid target contract');
    return target.functionCallWithValue(callData, value);
  }

  function initialize(address _lob, address _trader) initializer external override{
   
    factory = SmartWalletFactory(msg.sender);
    owner = _trader;
  }


  modifier onlyOwner() {
      require(owner == msg.sender, "Ownable: caller is not the owner");
      _;
  }

}

contract SmartWalletFactory is ISmartWalletFactory, Ownable{
  event Created(address indexed owner, address indexed smartWallet);

  mapping (address => address) public override getSmartWallet;
  mapping (address => bool) public isWhitelisted;

  address public LimitOrderBook;

  constructor(address _addr) public {
    LimitOrderBook = _addr;
  }

  /*
   * @notice Create and deploy a smart wallet for the user and stores the address
   */
  function spawn() external returns (address smartWallet) {
    require(getSmartWallet[msg.sender] == address(0), 'Already has smart wallet');

    bytes memory bytecode = type(SmartWallet).creationCode;
    bytes32 salt = keccak256(abi.encodePacked(msg.sender));
    assembly {
      smartWallet := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
    }

    emit Created(msg.sender, smartWallet);
    ISmartWallet(smartWallet).initialize(LimitOrderBook, msg.sender);
    getSmartWallet[msg.sender] = smartWallet;
  }

  function addToWhitelist(address _contract) external onlyOwner{
    isWhitelisted[_contract] = true;
  }

  function removeFromWhitelist(address _contract) external onlyOwner{
    isWhitelisted[_contract] = false;
  }

}