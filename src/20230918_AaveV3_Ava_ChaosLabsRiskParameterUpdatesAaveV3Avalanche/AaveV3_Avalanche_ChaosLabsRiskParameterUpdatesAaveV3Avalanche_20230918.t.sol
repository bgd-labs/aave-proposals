// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918} from './AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918.sol';

/**
 * @dev Test for AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918
 * command: make test-contract filter=AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918
 */
contract AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918_Test is
  ProtocolV3TestBase
{
  AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918 internal proposal;

  uint256 public constant WAVAX_LIQUIDATION_BONUS = 109_00; // 10% => 9%
  uint256 public constant SAVAX_LIQUIDATION_THRESHOLD = 40_00; // 30% => 40%
  uint256 public constant SAVAX_LOAN_TO_VALUE = 30_00; // 20% => 30%
  uint256 public constant LINK_E_LIQUIDATION_THRESHOLD = 71_00; // 68% => 71%
  uint256 public constant LINK_E_LOAN_TO_VALUE = 56_00; // 53% => 56%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 35348781);
    proposal = new AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918();
  }

  function testProposalExecution() public {
    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918',
      AaveV3Avalanche.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(
      vm,
      address(proposal),
      0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian
    );

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918',
      AaveV3Avalanche.POOL
    );

    // 4. Verify payloads
    // WAVAX
    ReserveConfig memory WAVAX_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.WAVAX_UNDERLYING
    );
    WAVAX_UNDERLYING_CONFIG.liquidationBonus = WAVAX_LIQUIDATION_BONUS;
    _validateReserveConfig(WAVAX_UNDERLYING_CONFIG, allConfigsAfter);

    // sAVAX
    ReserveConfig memory SAVAX_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.sAVAX_UNDERLYING
    );
    SAVAX_UNDERLYING_CONFIG.liquidationThreshold = SAVAX_LIQUIDATION_THRESHOLD;
    SAVAX_UNDERLYING_CONFIG.ltv = SAVAX_LOAN_TO_VALUE;
    _validateReserveConfig(SAVAX_UNDERLYING_CONFIG, allConfigsAfter);

    // LINKe
    ReserveConfig memory LINK_E_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.LINKe_UNDERLYING
    );
    LINK_E_UNDERLYING_CONFIG.liquidationThreshold = LINK_E_LIQUIDATION_THRESHOLD;
    LINK_E_UNDERLYING_CONFIG.ltv = LINK_E_LOAN_TO_VALUE;
    _validateReserveConfig(LINK_E_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918',
      'postAaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918'
    );

    // 6. E2E test
    e2eTest(AaveV3Avalanche.POOL);
  }
}
