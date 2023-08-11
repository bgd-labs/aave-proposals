// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_LUSDCollateralActivation_20230811} from './AaveV3_Ethereum_LUSDCollateralActivation_20230811.sol';

/**
 * @dev Test for AaveV3_Ethereum_LUSDCollateralActivation_20230811
 * command: make test-contract filter=AaveV3_Ethereum_LUSDCollateralActivation_20230811
 */
contract AaveV3_Ethereum_LUSDCollateralActivation_20230811_Test is ProtocolV3TestBase {
  uint256 public constant LUSD_UNDERLYING_LTV = 77_00; // 77.0%
  uint256 public constant LUSD_UNDERLYING_LIQ_THRESHOLD = 80_00; // 80.0%
  uint256 public constant LUSD_UNDERLYING_LIQ_BONUS = 10450; // 4.5%
  uint256 public constant LUSD_LIQUIDATION_PROTOCOL_FEE = 10_00; // 10.0%
  
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17890465);
  }

  function testProposalExecution() public {

    AaveV3_Ethereum_LUSDCollateralActivation_20230811 proposal = new AaveV3_Ethereum_LUSDCollateralActivation_20230811();


    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_LUSDCollateralActivation_20230811',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_LUSDCollateralActivation_20230811',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory LUSD_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.LUSD_UNDERLYING
    );

    LUSD_UNDERLYING_CONFIG.liquidationThreshold = LUSD_UNDERLYING_LIQ_THRESHOLD;
    LUSD_UNDERLYING_CONFIG.ltv = LUSD_UNDERLYING_LTV;
    LUSD_UNDERLYING_CONFIG.liquidationBonus = LUSD_UNDERLYING_LIQ_BONUS;
    LUSD_UNDERLYING_CONFIG.liquidationProtocolFee = LUSD_LIQUIDATION_PROTOCOL_FEE;
    LUSD_UNDERLYING_CONFIG.usageAsCollateralEnabled = true;

    _validateReserveConfig(LUSD_UNDERLYING_CONFIG, allConfigsAfter);

    e2eTestAsset(
      AaveV3Ethereum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.USDC_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.LUSD_UNDERLYING)
    );

    diffReports(
      'preAaveV3_Ethereum_LUSDCollateralActivation_20230811',
      'postAaveV3_Ethereum_LUSDCollateralActivation_20230811'
    );
  }
}
