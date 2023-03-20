// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3OptOPEmissionAdminPayload} from '../../contracts/optimism/AaveV3OptOPEmissionAdminPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

contract AaveV3OptOPEmissionAdminPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3OptOPEmissionAdminPayload public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 81107321);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testOPEmissionAdminOp() public {
    address OPTIMISM_FOUNDATION = 0x2501c477D0A35545a387Aa4A3EEe4292A9a8B3F0;

    IEmissionManager manager = IEmissionManager(AaveV3Optimism.EMISSION_MANAGER);
    proposalPayload = new AaveV3OptOPEmissionAdminPayload();

    assertEq(manager.getEmissionAdmin(proposalPayload.OP()), OPTIMISM_FOUNDATION);

    _executePayload(address(proposalPayload));

    assertEq(manager.getEmissionAdmin(proposalPayload.OP()), proposalPayload.NEW_EMISSION_ADMIN());
    emit log_named_address(
      'new emission admin for OP optimism rewards',
      manager.getEmissionAdmin(proposalPayload.OP())
    );

    /// verify admin can make changes
    vm.startPrank(proposalPayload.NEW_EMISSION_ADMIN());
    manager.setDistributionEnd(proposalPayload.OP(), proposalPayload.OP(), 0);
    vm.stopPrank();

    /// verify old admin cannot make changes
    vm.startPrank(OPTIMISM_FOUNDATION);
    address OP = proposalPayload.OP();
    vm.expectRevert('ONLY_EMISSION_ADMIN');
    manager.setDistributionEnd(OP, OP, 0);
    vm.stopPrank();
  }
}
