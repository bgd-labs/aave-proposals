// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_VGHOImprovement_20230826} from './AaveV3_Ethereum_VGHOImprovement_20230826.sol';

/**
 * @dev Test for AaveV3_Ethereum_VGHOImprovement_20230826
 * command: make test-contract filter=AaveV3_Ethereum_VGHOImprovement_20230826
 */
contract AaveV3_Ethereum_VGHOImprovement_20230826_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_VGHOImprovement_20230826 internal proposal;
  address constant NEW_VGHO_IMPL = 0x7aa606b1B341fFEeAfAdbbE4A2992EFB35972775;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18008130);
    proposal = new AaveV3_Ethereum_VGHOImprovement_20230826(NEW_VGHO_IMPL);
  }

  function testProposalExecution() public {
    createConfigurationSnapshot('preAaveV3_Ethereum_VGHOImprovement_20230826', AaveV3Ethereum.POOL);

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    createConfigurationSnapshot(
      'postAaveV3_Ethereum_VGHOImprovement_20230826',
      AaveV3Ethereum.POOL
    );

    e2eTest(AaveV3Ethereum.POOL);

    diffReports(
      'preAaveV3_Ethereum_VGHOImprovement_20230826',
      'postAaveV3_Ethereum_VGHOImprovement_20230826'
    );
  }
}
