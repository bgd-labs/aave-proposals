// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2CRVRiskParams_20230621} from './AaveV2CRVRiskParams_20230621.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

contract AaveV2CRVRiskParams_20230621_Test is ProtocolV2TestBase {
  uint256 public constant CRV_LTV = 49_00; // 49%
  uint256 public constant CRV_LIQUIDATION_THRESHOLD = 55_00; // 55%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17533013);
  }

  function testPayload() public {
    AaveV2CRVRiskParams_20230621 proposalPayload = new AaveV2CRVRiskParams_20230621();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2CRVRiskParams_20230621Change',
      AaveV2Ethereum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2CRVRiskParams_20230621Change',
      AaveV2Ethereum.POOL
    );

    // 4. Verify payload:

    ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.CRV_UNDERLYING
    );

    CRV_UNDERLYING_CONFIG.liquidationThreshold = CRV_LIQUIDATION_THRESHOLD;

    CRV_UNDERLYING_CONFIG.ltv = CRV_LTV;

    _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV2CRVRiskParams_20230621Change', 'postAaveV2CRVRiskParams_20230621Change');
  }
}
