// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_TestProposal_20231006} from './AaveV2Ethereum_TestProposal_20231006.sol';

/**
 * @dev Test for AaveV2Ethereum_TestProposal_20231006
 * command: make test-contract filter=AaveV2Ethereum_TestProposal_20231006
 */
contract AaveV2Ethereum_TestProposal_20231006_Test is ProtocolV2TestBase {
  AaveV2Ethereum_TestProposal_20231006 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18291494);
    proposal = new AaveV2Ethereum_TestProposal_20231006();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2Ethereum_TestProposal_20231006',
      AaveV2Ethereum.POOL
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2Ethereum_TestProposal_20231006',
      AaveV2Ethereum.POOL
    );

    diffReports(
      'preAaveV2Ethereum_TestProposal_20231006',
      'postAaveV2Ethereum_TestProposal_20231006'
    );
  }
}
