// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3_0_1TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthcbETHPayload} from '../../contracts/mainnet/AaveV3EthcbETHPayload.sol';

contract AaveV3EthcbETHPayloadTest is ProtocolV3_0_1TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16519524);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPoolActivation() public {
    AaveV3EthcbETHPayload cbETH = new AaveV3EthcbETHPayload();

    createConfigurationSnapshot('pre-cbETH', AaveV3Ethereum.POOL);

    _executePayload(address(cbETH));

    createConfigurationSnapshot('post-cbETH', AaveV3Ethereum.POOL);
  }
}
