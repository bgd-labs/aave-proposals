// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829.sol';

/**
 * @dev Test for AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829
 * command: make test-contract filter=AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829
 */
contract AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829_Test is ProtocolV3TestBase {
  AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 34524913);
    proposal = new AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829',
      AaveV3Avalanche.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829',
      AaveV3Avalanche.POOL
    );

    diffReports(
      'preAaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829',
      'postAaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829'
    );
  }
}
