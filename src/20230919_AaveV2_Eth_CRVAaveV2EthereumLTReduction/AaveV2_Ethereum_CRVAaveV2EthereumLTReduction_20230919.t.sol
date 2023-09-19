// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919} from './AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919.sol';

/**
 * @dev Test for AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919
 * command: make test-contract filter=AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919
 */
contract AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919_Test is ProtocolV2TestBase {
  AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919 internal proposal;

  uint256 public constant CRV_LIQUIDATION_THRESHOLD = 45_00; // 45%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18168802);
    proposal = new AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919',
      AaveV2Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919',
      AaveV2Ethereum.POOL
    );

    ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.CRV_UNDERLYING
    );
    CRV_UNDERLYING_CONFIG.liquidationThreshold = CRV_LIQUIDATION_THRESHOLD;
    _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

    diffReports(
      'preAaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919',
      'postAaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919'
    );

    e2eTest(AaveV2Ethereum.POOL);
  }
}
