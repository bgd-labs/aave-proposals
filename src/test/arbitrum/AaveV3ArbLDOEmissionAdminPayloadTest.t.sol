// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Arbitrum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbLDOEmissionAdminPayload} from '../../contracts/arbitrum/AaveV3ArbLDOEmissionAdminPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

contract AaveV3ArbLDOEmissionAdminPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3ArbLDOEmissionAdminPayload public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 62456736);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testLdoEmissionAdminArb() public {
    IEmissionManager manager = IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER);
    proposalPayload = new AaveV3ArbLDOEmissionAdminPayload();

    assertEq(manager.getEmissionAdmin(proposalPayload.LDO()), address(0));

    _executePayload(address(proposalPayload));

    assertEq(manager.getEmissionAdmin(proposalPayload.LDO()), proposalPayload.NEW_EMISSION_ADMIN());
    emit log_named_address(
      'new emission admin for LDO arbitrum rewards',
      manager.getEmissionAdmin(proposalPayload.LDO())
    );

    /// verify admin can make changes
    vm.startPrank(proposalPayload.NEW_EMISSION_ADMIN());
    manager.setDistributionEnd(proposalPayload.LDO(), proposalPayload.LDO(), 0);
    vm.stopPrank();
  }
}
