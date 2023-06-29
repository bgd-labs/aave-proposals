// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Metis} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3MetisEmissionAdminUpdate_20230629} from './AaveV3MetisEmissionAdminUpdate_20230629.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

contract AaveV3MetisEmissionAdminUpdate_20230629Test is ProtocolV3TestBase, TestWithExecutor {
  AaveV3MetisEmissionAdminUpdate_20230629 public proposalPayload;

  function setUp() public {
    vm.createSelectFork('https://andromeda.metis.io/?owner=1088', 6634879);
    _selectPayloadExecutor(AaveGovernanceV2.METIS_BRIDGE_EXECUTOR);
  }

  function testMETISEmissionAdminMetis() public {
    IEmissionManager manager = IEmissionManager(AaveV3Metis.EMISSION_MANAGER);
    proposalPayload = new AaveV3MetisEmissionAdminUpdate_20230629();

    assertEq(manager.getEmissionAdmin(proposalPayload.METIS()), address(0));

    _executePayload(address(proposalPayload));

    assertEq(manager.getEmissionAdmin(proposalPayload.METIS()), proposalPayload.EMISSION_ADMIN());
    emit log_named_address(
      'Emission admin for METIS rewards on Metis',
      manager.getEmissionAdmin(proposalPayload.METIS())
    );

    /// verify admin can make changes
    vm.startPrank(proposalPayload.EMISSION_ADMIN());
    manager.setDistributionEnd(proposalPayload.METIS(), proposalPayload.METIS(), 0);
    vm.stopPrank();
  }
}