// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_StataTokenOperationalUpdate_20230815} from './AaveV3_Ethereum_StataTokenOperationalUpdate_20230815.sol';

/**
 * @dev Test for AaveV3_Ethereum_StataTokenOperationalUpdate_20230815
 * command: make test-contract filter=AaveV3_Ethereum_StataTokenOperationalUpdate_20230815
 */
contract AaveV3_Ethereum_StataTokenOperationalUpdate_20230815_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_StataTokenOperationalUpdate_20230815 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17918848);
    proposal = new AaveV3_Ethereum_StataTokenOperationalUpdate_20230815();
  }

  function testProposalExecution() public {
    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);
  }
}
