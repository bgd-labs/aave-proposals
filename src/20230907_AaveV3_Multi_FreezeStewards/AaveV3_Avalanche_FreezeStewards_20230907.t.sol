// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveConfiguration, DataTypes} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Avalanche_FreezeStewards_20230907} from './AaveV3_Avalanche_FreezeStewards_20230907.sol';
import {FreezingSteward} from './FreezingSteward.sol';

/**
 * @dev Test for AaveV3_Avalanche_FreezeStewards_20230907
 * command: make test-contract filter=AaveV3_Avalanche_FreezeStewards_20230907
 */
contract AaveV3_Avalanche_FreezeStewards_20230907_Test is ProtocolV3TestBase {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  AaveV3_Avalanche_FreezeStewards_20230907 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 34874495);
    address freezingSteward = address(
      new FreezingSteward(AaveV3Avalanche.ACL_MANAGER, AaveV3Avalanche.POOL_CONFIGURATOR)
    );

    proposal = new AaveV3_Avalanche_FreezeStewards_20230907(freezingSteward);
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3_Avalanche_FreezeStewards_20230907',
      AaveV3Avalanche.POOL
    );

    address freezingSteward = proposal.FREEZING_STEWARD();

    assertFalse(AaveV3Avalanche.ACL_MANAGER.isRiskAdmin(freezingSteward));
    assertFalse(
      AaveV3Avalanche.POOL.getConfiguration(AaveV3AvalancheAssets.USDC_UNDERLYING).getFrozen()
    );
    vm.expectRevert(bytes('ONLY_EMERGENCY_ADMIN'));
    FreezingSteward(freezingSteward).setFreeze(AaveV3AvalancheAssets.USDC_UNDERLYING, true);

    GovHelpers.executePayload(
      vm,
      address(proposal),
      0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian
    );

    assertTrue(AaveV3Avalanche.ACL_MANAGER.isRiskAdmin(freezingSteward));
    
    vm.prank(0xa35b76E4935449E33C56aB24b23fcd3246f13470);
    AaveV3Avalanche.ACL_MANAGER.addEmergencyAdmin(address(this));
    
    FreezingSteward(freezingSteward).setFreeze(AaveV3AvalancheAssets.USDC_UNDERLYING, true);
    
    assertTrue(
      AaveV3Avalanche.POOL.getConfiguration(AaveV3AvalancheAssets.USDC_UNDERLYING).getFrozen()
    );
    FreezingSteward(freezingSteward).setFreeze(AaveV3AvalancheAssets.USDC_UNDERLYING, false);

    createConfigurationSnapshot(
      'postAaveV3_Avalanche_FreezeStewards_20230907',
      AaveV3Avalanche.POOL
    );

    diffReports(
      'preAaveV3_Avalanche_FreezeStewards_20230907',
      'postAaveV3_Avalanche_FreezeStewards_20230907'
    );
  }
}
