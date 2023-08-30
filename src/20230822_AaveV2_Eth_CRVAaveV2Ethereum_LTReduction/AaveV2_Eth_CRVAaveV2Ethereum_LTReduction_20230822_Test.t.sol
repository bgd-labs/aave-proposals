// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822} from './AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822.sol';

/**
 * @dev Test for AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822
 * command: make test-contract filter=AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822
 */
contract AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822_Test is ProtocolV2TestBase {
  uint256 public constant CRV_LIQUIDATION_THRESHOLD = 47_00; // 47%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17967854);
  }

  function testProposalExecution() public {
    AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822 proposal = new AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822();
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822_Test',
      AaveV2Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822_Test',
      AaveV2Ethereum.POOL
    );

    ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.CRV_UNDERLYING
    );
    CRV_UNDERLYING_CONFIG.liquidationThreshold = CRV_LIQUIDATION_THRESHOLD;
    _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

    diffReports(
      'preAaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822_Test',
      'postAaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822_Test'
    );

    e2eTest(AaveV2Ethereum.POOL);
  }
}
