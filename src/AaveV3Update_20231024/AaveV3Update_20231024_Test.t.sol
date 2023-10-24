
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {
  AaveV3Ethereum,
  AaveV3EthereumAssets
} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {
  AaveV3EthereumUpdate20231024Payload
} from './AaveV3Ethereum_20231024.sol';

contract AaveV3EthereumUpdate_20231024_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18422833);
  }

  function testEthereum20231024UpdatePayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestEthereumUpdate20231024',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory WETH_UNDERLYINGBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV3EthereumUpdate20231024Payload()),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestEthereumUpdate20231024',
      AaveV3Ethereum.POOL
    );

    diffReports('preTestEthereumUpdate20231024', 'postTestEthereumUpdate20231024');

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3EthereumAssets.WETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory WETH_UNDERLYINGAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3EthereumAssets.WETH_UNDERLYING
      );
      WETH_UNDERLYINGBefore.interestRateStrategy = WETH_UNDERLYINGAfter.interestRateStrategy;
      _validateReserveConfig(WETH_UNDERLYINGBefore, allConfigsAfter);
    }
    e2eTest(AaveV3Ethereum.POOL);
  }
}