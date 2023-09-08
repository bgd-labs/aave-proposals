// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveConfiguration, DataTypes} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Arbitrum_FreezeStewards_20230907} from './AaveV3_Arbitrum_FreezeStewards_20230907.sol';
import {FreezingSteward} from './FreezingSteward.sol';

/**
 * @dev Test for AaveV3_Arbitrum_FreezeStewards_20230907
 * command: make test-contract filter=AaveV3_Arbitrum_FreezeStewards_20230907
 */
contract AaveV3_Arbitrum_FreezeStewards_20230907_Test is ProtocolV3TestBase {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  AaveV3_Arbitrum_FreezeStewards_20230907 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 128829910);
    address freezingSteward = address(
      new FreezingSteward(AaveV3Arbitrum.ACL_MANAGER, AaveV3Arbitrum.POOL_CONFIGURATOR)
    );

    proposal = new AaveV3_Arbitrum_FreezeStewards_20230907(freezingSteward);
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3_Arbitrum_FreezeStewards_20230907',
      AaveV3Arbitrum.POOL
    );

    address freezingSteward = proposal.FREEZING_STEWARD();

    assertFalse(AaveV3Arbitrum.ACL_MANAGER.isRiskAdmin(freezingSteward));
    assertFalse(
      AaveV3Arbitrum.POOL.getConfiguration(AaveV3ArbitrumAssets.USDC_UNDERLYING).getFrozen()
    );
    vm.expectRevert(bytes("ONLY_EMERGENCY_ADMIN"));
    FreezingSteward(freezingSteward).setFreeze(AaveV3ArbitrumAssets.USDC_UNDERLYING, true);

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    assertTrue(AaveV3Arbitrum.ACL_MANAGER.isRiskAdmin(freezingSteward));
    
    vm.prank(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
    AaveV3Arbitrum.ACL_MANAGER.addEmergencyAdmin(address(this));

    FreezingSteward(freezingSteward).setFreeze(AaveV3ArbitrumAssets.USDC_UNDERLYING, true);

    assertTrue(
      AaveV3Arbitrum.POOL.getConfiguration(AaveV3ArbitrumAssets.USDC_UNDERLYING).getFrozen()
    );
    FreezingSteward(freezingSteward).setFreeze(AaveV3ArbitrumAssets.USDC_UNDERLYING, false);

    createConfigurationSnapshot(
      'postAaveV3_Arbitrum_FreezeStewards_20230907',
      AaveV3Arbitrum.POOL
    );

    diffReports(
      'preAaveV3_Arbitrum_FreezeStewards_20230907',
      'postAaveV3_Arbitrum_FreezeStewards_20230907'
    );
  }
}
