// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Ethereum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthLDOEmissionAdminPayload} from '../../contracts/mainnet/AaveV3EthLDOEmissionAdminPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

contract AaveV3EthLDOEmissionAdminPayloadTest is
  ProtocolV3TestBase,
  TestWithExecutor
{
  AaveV3EthLDOEmissionAdminPayload public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'));
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testLdoEmissionAdminOp() public {
    IEmissionManager manager = IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER);
    proposalPayload = new AaveV3EthLDOEmissionAdminPayload();

    assertEq(manager.getEmissionAdmin(proposalPayload.LDO()), address(0));

    _executePayload(address(proposalPayload));

    assertEq(manager.getEmissionAdmin(proposalPayload.LDO()), proposalPayload.NEW_EMISSION_ADMIN());
    emit log_named_address('new emission admin for LDO mainnet rewards', manager.getEmissionAdmin(proposalPayload.LDO()));
    
    /// verify admin can make changes
    vm.startPrank(proposalPayload.NEW_EMISSION_ADMIN());
    manager.setDistributionEnd(proposalPayload.LDO(), proposalPayload.LDO(), 0);
    vm.stopPrank();
  }
}