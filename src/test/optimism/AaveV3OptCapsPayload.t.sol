// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
import {AaveV3OptCapsPayload} from '../../contracts/optimism/AaveV3OptCapsPayload.sol';
import {BaseTest} from '../utils/BaseTest.sol';

contract AaveV3OptCapsPayloadTest is ProtocolV3TestBase, BaseTest {
  AaveV3OptCapsPayload public proposalPayload;

  address public constant AAVE = 0x76FB31fb4af56892A25e32cFC43De717950c9278;

  // 100k AAVE
  uint256 public constant AAVE_CAP = 100_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 44920020);
    _setUp(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testProposalE2E() public {
    // we get all configs to later on check that payload only changes OP
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Optimism.POOL
    );

    // 1. deploy l2 payload
    proposalPayload = new AaveV3OptCapsPayload();

    // 2. execute l2 payload
    _execute(address(proposalPayload));

    // 5. verify results
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(
      AaveV3Optimism.POOL
    );

    // AAVE
    ReserveConfig memory LinkConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AAVE
    );
    LinkConfig.supplyCap = AAVE_CAP;
    ProtocolV3TestBase._validateReserveConfig(LinkConfig, allConfigsAfter);
  }
}
