// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthTestProposal20230307} from './AaveV3EthTestProposal20230307.sol';

contract AaveV3EthTestProposal20230307_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), replaceWithCurrentBlockNumber);
  }

  function testProposalExecution() public {
    AaveV3EthTestProposal20230307 proposal = new AaveV3EthTestProposal20230307();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3EthTestProposal20230307',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      replaceWithCorrectExecutor
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'preAaveV3EthTestProposal20230307',
      AaveV3Ethereum.POOL
    );
  }
}
