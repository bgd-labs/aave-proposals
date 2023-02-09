// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3OptLDOEmissionAdminPayload} from '../../contracts/optimism/AaveV3OptLDOEmissionAdminPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

contract AaveV3OptLDOEmissionAdminPayloadTest is
  ProtocolV3TestBase,
  TestWithExecutor
{
  AaveV3OptLDOEmissionAdminPayload public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'));
    _selectPayloadExecutor(AaveV3Optimism.ACL_ADMIN);
  }

  function testLdoEmissionAdminOp() public {
    IEmissionManager manager = IEmissionManager(AaveV3Optimism.EMISSION_MANAGER);
    proposalPayload = new AaveV3OptLDOEmissionAdminPayload();

    assertEq(manager.getEmissionAdmin(proposalPayload.LDO()), address(0));

    _executePayload(address(proposalPayload));

    assertEq(manager.getEmissionAdmin(proposalPayload.LDO()), proposalPayload.NEW_EMISSION_ADMIN());
    emit log_named_address('new emission admin for LDO optimism rewards', manager.getEmissionAdmin(proposalPayload.LDO()));
    
    /// verify admin can make changes
    vm.startPrank(proposalPayload.NEW_EMISSION_ADMIN());
    manager.setDistributionEnd(proposalPayload.LDO(), proposalPayload.LDO(), 0);
    vm.stopPrank();
  }
}