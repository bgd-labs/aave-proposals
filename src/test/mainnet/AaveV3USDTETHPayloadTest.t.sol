// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3_0_1TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthUSDTPayload} from '../../contracts/mainnet/AaveV3EthUSDTPayload.sol';

contract AaveV3EthUSDTPayloadTest is ProtocolV3_0_1TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16576447);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPoolActivation() public {
    AaveV3EthUSDTPayload usdtPayload = new AaveV3EthUSDTPayload();

    createConfigurationSnapshot('pre-USDT-aave-v3-ethereum', AaveV3Ethereum.POOL);

    _executePayload(address(usdtPayload));

    createConfigurationSnapshot('post-USDT-aave-v3-ethereum', AaveV3Ethereum.POOL);

    diffReports('pre-USDT-aave-v3-ethereum','post-USDT-aave-v3-ethereum');
  }
}
