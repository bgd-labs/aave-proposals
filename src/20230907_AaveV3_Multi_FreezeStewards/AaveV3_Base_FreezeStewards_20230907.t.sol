// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Base_FreezeStewards_20230907} from './AaveV3_Base_FreezeStewards_20230907.sol';
import {FreezingSteward} from './FreezingSteward.sol';

/**
 * @dev Test for AaveV3_Base_FreezeStewards_20230907
 * command: make test-contract filter=AaveV3_Base_FreezeStewards_20230907
 */
contract AaveV3_Base_FreezeStewards_20230907_Test is ProtocolV3TestBase {
  AaveV3_Base_FreezeStewards_20230907 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 3644020);
    address freezingSteward = address(
      new FreezingSteward(AaveV3Base.ACL_MANAGER, AaveV3Base.POOL_CONFIGURATOR)
    );
    proposal = new AaveV3_Base_FreezeStewards_20230907(freezingSteward);
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Base_FreezeStewards_20230907',
      AaveV3Base.POOL
    );

    address freezingSteward = proposal.FREEZING_STEWARD();

    assertFalse(AaveV3Base.ACL_MANAGER.isRiskAdmin(freezingSteward));

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.BASE_BRIDGE_EXECUTOR);

    assertTrue(AaveV3Base.ACL_MANAGER.isRiskAdmin(freezingSteward));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Base_FreezeStewards_20230907',
      AaveV3Base.POOL
    );

    diffReports(
      'preAaveV3_Base_FreezeStewards_20230907',
      'postAaveV3_Base_FreezeStewards_20230907'
    );
  }
}
