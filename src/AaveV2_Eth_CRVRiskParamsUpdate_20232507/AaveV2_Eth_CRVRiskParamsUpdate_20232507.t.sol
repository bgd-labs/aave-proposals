// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Eth_CRVRiskParamsUpdate_20232507} from './AaveV2_Eth_CRVRiskParamsUpdate_20232507.sol';

/**
 * @dev Test for AaveV2_Eth_CRVRiskParamsUpdate_20232507
 * command: make test-contract filter=AaveV2_Eth_CRVRiskParamsUpdate_20232507
 */
contract AaveV2_Eth_CRVRiskParamsUpdate_20232507_Test is ProtocolV2TestBase {
  uint256 public constant CRV_LTV = 43_00; // 43%
  uint256 public constant CRV_LIQUIDATION_THRESHOLD = 49_00; // 49%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17768749);
  }

  function testProposalExecution() public {
    AaveV2_Eth_CRVRiskParamsUpdate_20232507 proposal = new AaveV2_Eth_CRVRiskParamsUpdate_20232507();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2_Eth_CRVRiskParamsUpdate_20232507',
      AaveV2Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2_Eth_CRVRiskParamsUpdate_20232507',
      AaveV2Ethereum.POOL
    );

    ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.CRV_UNDERLYING
    );
    CRV_UNDERLYING_CONFIG.liquidationThreshold = CRV_LIQUIDATION_THRESHOLD;
    CRV_UNDERLYING_CONFIG.ltv = CRV_LTV;
    _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

    diffReports(
      'preAaveV2_Eth_CRVRiskParamsUpdate_20232507',
      'postAaveV2_Eth_CRVRiskParamsUpdate_20232507'
    );

    e2eTest(AaveV2Ethereum.POOL);
  }
}
