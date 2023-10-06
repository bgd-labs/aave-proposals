// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_TestProposal_20231006} from './AaveV3Ethereum_TestProposal_20231006.sol';

/**
 * @dev Test for AaveV3Ethereum_TestProposal_20231006
 * command: make test-contract filter=AaveV3Ethereum_TestProposal_20231006
 */
contract AaveV3Ethereum_TestProposal_20231006_Test is ProtocolV3TestBase {
  AaveV3Ethereum_TestProposal_20231006 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18291494);
    proposal = new AaveV3Ethereum_TestProposal_20231006();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3Ethereum_TestProposal_20231006',
      AaveV3Ethereum.POOL
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3Ethereum_TestProposal_20231006',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'preAaveV3Ethereum_TestProposal_20231006',
      'postAaveV3Ethereum_TestProposal_20231006'
    );
  }
}
