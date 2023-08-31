// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829.sol';

/**
 * @dev Test for AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829
 * command: make test-contract filter=AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829
 */
contract AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18021217);
    proposal = new AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'preAaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829',
      'postAaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829'
    );
  }
}
