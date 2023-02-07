// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3_0_1TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthrETHPayload} from '../../contracts/mainnet/AaveV3EthrETHPayload.sol';

contract AaveV3EthrETHPayloadTest is ProtocolV3_0_1TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16576684);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPoolActivation() public {
    AaveV3EthrETHPayload rETH = new AaveV3EthrETHPayload();

    createConfigurationSnapshot('pre-rETH', AaveV3Ethereum.POOL);

    _executePayload(address(rETH));

    createConfigurationSnapshot('post-rETH', AaveV3Ethereum.POOL);

    // diffReports('pre-rETH', 'post-rETH');
  }
}
