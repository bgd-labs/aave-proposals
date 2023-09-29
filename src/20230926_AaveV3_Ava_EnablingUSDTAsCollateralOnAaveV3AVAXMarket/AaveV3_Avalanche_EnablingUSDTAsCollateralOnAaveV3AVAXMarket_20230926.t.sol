// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926} from './AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926.sol';

/**
 * @dev Test for AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926
 * command: make test-contract filter=AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926
 */
contract AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926_Test is
  ProtocolV3TestBase
{
  AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 35697760);
    proposal = new AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926();
  }

  function testProposalExecution() public {
    uint256 BORROW_CAP = proposal.BORROW_CAP();
    uint256 SUPPLY_CAP = proposal.SUPPLY_CAP();
    uint256 DEBT_CEILING = proposal.DEBT_CEILING();

    // Create pre-execution snapshot

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926',
      AaveV3Avalanche.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian
    );

    // Create post-execution snapshot

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926',
      AaveV3Avalanche.POOL
    );

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3AvalancheAssets.USDt_UNDERLYING
    );

    ReserveConfig memory USDt_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.USDt_UNDERLYING
    );

    USDt_UNDERLYING_CONFIG.borrowCap = BORROW_CAP;
    USDt_UNDERLYING_CONFIG.supplyCap = SUPPLY_CAP;
    USDt_UNDERLYING_CONFIG.debtCeiling = DEBT_CEILING;

    _validateReserveConfig(USDt_UNDERLYING_CONFIG, allConfigsAfter);

    e2eTest(AaveV3Avalanche.POOL);

    diffReports(
      'preAaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926',
      'postAaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926'
    );
  }
}
