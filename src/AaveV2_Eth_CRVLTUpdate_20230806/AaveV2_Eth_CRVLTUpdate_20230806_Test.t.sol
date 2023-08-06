// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Eth_CRVLTUpdate_20230806} from './AaveV2_Eth_CRVLTUpdate_20230806.sol';

/**
 * @dev Test for AaveV2_Eth_CRVLTUpdate_20230806_Test
 * command: make test-contract filter=AaveV2_Eth_CRVLTUpdate_20230806_Test
 */
contract AaveV2_Eth_CRVLTUpdate_20230806_Test is ProtocolV2TestBase {
  uint256 public constant CRV_LIQUIDATION_THRESHOLD = 49_00; // 49%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17856818);
  }

  function testProposalExecution() public {
    AaveV2_Eth_CRVLTUpdate_20230806 proposal = new AaveV2_Eth_CRVLTUpdate_20230806();
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2_Eth_CRVLTUpdate_20230806_Test',
      AaveV2Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2_Eth_CRVLTUpdate_20230806_Test',
      AaveV2Ethereum.POOL
    );

    ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.CRV_UNDERLYING
    );
    CRV_UNDERLYING_CONFIG.liquidationThreshold = CRV_LIQUIDATION_THRESHOLD;
    _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

    diffReports(
      'preAaveV2_Eth_CRVLTUpdate_20230806_Test',
      'postAaveV2_Eth_CRVLTUpdate_20230806_Test'
    );

    e2eTestAsset(
      AaveV2Ethereum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV2EthereumAssets.WETH_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV2EthereumAssets.CRV_UNDERLYING)
    );
  }
}
