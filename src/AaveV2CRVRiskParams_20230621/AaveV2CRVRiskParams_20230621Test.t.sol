// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2CRVRiskParams_20230621} from './AaveV2CRVRiskParams_20230621.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

contract AaveV2CRVRiskParams_20230621_Test is ProtocolV2TestBase, TestWithExecutor {
  uint256 public constant CRV_LTV = 49_00; // 49%
  uint256 public constant CRV_LIQUIDATION_THRESHOLD = 55_00; // 55%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17533013);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPayload() public {
    AaveV2CRVRiskParams_20230621 proposalPayload = new AaveV2CRVRiskParams_20230621();

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV2Ethereum.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV2CRVRiskParams_20230621Change', AaveV2Ethereum.POOL);

    // 2. execute payload
    _executePayload(address(proposalPayload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot('postAaveV2CRVRiskParams_20230621Change', AaveV2Ethereum.POOL);

    // 4. Verify payload:
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV2Ethereum.POOL);

    ReserveConfig memory CRV_UNDERLYING_CONFIG = ProtocolV2TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.CRV_UNDERLYING
    );

    CRV_UNDERLYING_CONFIG.liquidationThreshold = CRV_LIQUIDATION_THRESHOLD;

    CRV_UNDERLYING_CONFIG.ltv = CRV_LTV;

    ProtocolV2TestBase._validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV2CRVRiskParams_20230621Change', 'postAaveV2CRVRiskParams_20230621Change');
  }
}
