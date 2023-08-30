// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828} from './AaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828.sol';

/**
 * @dev Test for AaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828
 * command: make test-contract filter=AaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828
 */
contract AaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828_Test is
  ProtocolV3TestBase
{
  uint256 public constant DAI_UNDERLYING_LIQ_BONUS = 10500; // 5%
  uint256 public constant WSTETH_UNDERLYING_LTV = 78_50; // 78.5%
  uint256 public constant WSTETH_UNDERLYING_LIQ_THRESHOLD = 81_00; // 81.0%
  uint256 public constant CBETH_UNDERLYING_LTV = 74_50; // 74.5%
  uint256 public constant CBETH_UNDERLYING_LIQ_THRESHOLD = 77_00; // 77.0%
  uint256 public constant RETH_UNDERLYING_LTV = 74_50; // 74.5%
  uint256 public constant RETH_UNDERLYING_LIQ_THRESHOLD = 77_00; // 77.0%

  AaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18011915);
    proposal = new AaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory DAI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.DAI_UNDERLYING
    );
    DAI_UNDERLYING_CONFIG.liquidationBonus = DAI_UNDERLYING_LIQ_BONUS;

    ReserveConfig memory WSTETH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.wstETH_UNDERLYING
    );
    WSTETH_UNDERLYING_CONFIG.liquidationThreshold = WSTETH_UNDERLYING_LIQ_THRESHOLD;
    WSTETH_UNDERLYING_CONFIG.ltv = WSTETH_UNDERLYING_LTV;

    ReserveConfig memory CBETH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.cbETH_UNDERLYING
    );
    CBETH_UNDERLYING_CONFIG.liquidationThreshold = CBETH_UNDERLYING_LIQ_THRESHOLD;
    CBETH_UNDERLYING_CONFIG.ltv = CBETH_UNDERLYING_LTV;

    ReserveConfig memory RETH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.rETH_UNDERLYING
    );
    RETH_UNDERLYING_CONFIG.liquidationThreshold = RETH_UNDERLYING_LIQ_THRESHOLD;
    RETH_UNDERLYING_CONFIG.ltv = RETH_UNDERLYING_LTV;

    _validateReserveConfig(DAI_UNDERLYING_CONFIG, allConfigsAfter);
    _validateReserveConfig(WSTETH_UNDERLYING_CONFIG, allConfigsAfter);
    _validateReserveConfig(CBETH_UNDERLYING_CONFIG, allConfigsAfter);
    _validateReserveConfig(RETH_UNDERLYING_CONFIG, allConfigsAfter);

    e2eTest(AaveV3Ethereum.POOL);

    diffReports(
      'preAaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828',
      'postAaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828'
    );
  }
}
