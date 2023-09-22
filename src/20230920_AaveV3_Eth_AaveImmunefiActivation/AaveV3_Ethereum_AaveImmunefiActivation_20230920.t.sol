// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_AaveImmunefiActivation_20230920} from './AaveV3_Ethereum_AaveImmunefiActivation_20230920.sol';

/**
 * @dev Test for AaveV3_Ethereum_AaveImmunefiActivation_20230920
 * command: make test-contract filter=AaveV3_Ethereum_AaveImmunefiActivation_20230920
 */
contract AaveV3_Ethereum_AaveImmunefiActivation_20230920_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_AaveImmunefiActivation_20230920 internal proposal;

  event Decision(string agreed);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18176275);
    proposal = new AaveV3_Ethereum_AaveImmunefiActivation_20230920();
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3_Ethereum_AaveImmunefiActivation_20230920',
      AaveV3Ethereum.POOL
    );

    vm.expectEmit();
    emit Decision(
      'The Aave DAO authorises the activation of an Aave <> Immunefi bug bounty program'
    );
    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    createConfigurationSnapshot(
      'postAaveV3_Ethereum_AaveImmunefiActivation_20230920',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'preAaveV3_Ethereum_AaveImmunefiActivation_20230920',
      'postAaveV3_Ethereum_AaveImmunefiActivation_20230920'
    );
  }
}
