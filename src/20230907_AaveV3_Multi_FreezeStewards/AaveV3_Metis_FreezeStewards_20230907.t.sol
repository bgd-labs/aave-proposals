// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveConfiguration, DataTypes} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Metis_FreezeStewards_20230907} from './AaveV3_Metis_FreezeStewards_20230907.sol';
import {FreezingSteward} from './FreezingSteward.sol';

/**
 * @dev Test for AaveV3_Metis_FreezeStewards_20230907
 * command: make test-contract filter=AaveV3_Metis_FreezeStewards_20230907
 */
contract AaveV3_Metis_FreezeStewards_20230907_Test is ProtocolV3TestBase {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  AaveV3_Metis_FreezeStewards_20230907 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 8452282);
    address freezingSteward = address(
      new FreezingSteward(AaveV3Metis.ACL_MANAGER, AaveV3Metis.POOL_CONFIGURATOR)
    );
    proposal = new AaveV3_Metis_FreezeStewards_20230907(freezingSteward);
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3_Metis_FreezeStewards_20230907',
      AaveV3Metis.POOL
    );

    address freezingSteward = proposal.FREEZING_STEWARD();

    assertFalse(AaveV3Metis.ACL_MANAGER.isRiskAdmin(freezingSteward));
    assertFalse(AaveV3Metis.POOL.getConfiguration(AaveV3MetisAssets.mUSDC_UNDERLYING).getFrozen());
    vm.expectRevert(bytes('ONLY_EMERGENCY_ADMIN'));
    FreezingSteward(freezingSteward).setFreeze(AaveV3MetisAssets.mUSDC_UNDERLYING, true);

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.METIS_BRIDGE_EXECUTOR);

    assertTrue(AaveV3Metis.ACL_MANAGER.isRiskAdmin(freezingSteward));

    vm.prank(AaveGovernanceV2.METIS_BRIDGE_EXECUTOR);
    AaveV3Metis.ACL_MANAGER.addEmergencyAdmin(address(this));

    FreezingSteward(freezingSteward).setFreeze(AaveV3MetisAssets.mUSDC_UNDERLYING, true);

    assertTrue(
      AaveV3Metis.POOL.getConfiguration(AaveV3MetisAssets.mUSDC_UNDERLYING).getFrozen()
    );
    FreezingSteward(freezingSteward).setFreeze(AaveV3MetisAssets.mUSDC_UNDERLYING, false);

    createConfigurationSnapshot(
      'postAaveV3_Metis_FreezeStewards_20230907',
      AaveV3Metis.POOL
    );

    diffReports(
      'preAaveV3_Metis_FreezeStewards_20230907',
      'postAaveV3_Metis_FreezeStewards_20230907'
    );
  }
}
