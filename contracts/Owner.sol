// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.13;

import "./IInterchainAccountRouter.sol";
import {Call} from "./OwnableMulticall.sol";
import {SmartWallet} from "./AA/SmartWalletFactory.sol";

contract Owner {
    IInterchainAccountRouter router;

    constructor(address _router) {
        router = IInterchainAccountRouter(_router);
    }

        //keeping this as function name as is 
        //EVEN tho it is actually calling the contractfactory creation on the new chain.
    function setRemoteFee(
        uint32 _destinationDomain,
        address target,
        uint256 newFee
    ) external {

        //this triggers both smart contract creation and 
        //we can TransferFrom the origin chain smartcontract because we have approva;
        //deterministically send 


        Call[] memory calls = new Call[](1);
        calls[0] = Call({
            to: target,
            data: abi.encodeWithSelector(0x69fe0e2d, newFee)
        });
        router.dispatch(_destinationDomain, calls);
    }

    function transferRemoteOwnership(
        uint32 _destinationDomain,
        address target,
        address newOwner
    ) external {
        Call[] memory calls = new Call[](1);
        calls[0] = Call({
            to: target,
            data: abi.encodeWithSelector(0xf2fde38b, newOwner)
        });
        router.dispatch(_destinationDomain, calls);
    }
}
