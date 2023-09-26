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
   
   // Create pre-execution snapshot

    createConfigurationSnapshot(
      'preAaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926',
      AaveV3Avalanche.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian
    );

    // Create post-execution snapshot

    createConfigurationSnapshot(
      'postAaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926',
      AaveV3Avalanche.POOL
    );

    e2eTest(AaveV3Avalanche.POOL);

    diffReports(
      'preAaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926',
      'postAaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926'
    );
  }
}
