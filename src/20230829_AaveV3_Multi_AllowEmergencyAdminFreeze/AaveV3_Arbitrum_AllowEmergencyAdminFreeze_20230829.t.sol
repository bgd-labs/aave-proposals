// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829.sol';

/**
 * @dev Test for AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829
 * command: make test-contract filter=AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829
 */
contract AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829_Test is ProtocolV3TestBase {
  AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 126119624);
    proposal = new AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829',
      AaveV3Arbitrum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829',
      AaveV3Arbitrum.POOL
    );

    diffReports(
      'preAaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829',
      'postAaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829'
    );
  }
}
