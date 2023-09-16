// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Met_SetEmissionManager_20232607} from './AaveV3_Met_SetEmissionManager_20232607.sol';

/**
 * @dev Test for AaveV3_Met_SetEmissionManager_20232607
 * command: make test-contract filter=AaveV3_Met_SetEmissionManager_20232607
 */
contract AaveV3_Met_SetEmissionManager_20232607_Test is ProtocolV3TestBase {

  address public constant METIS = AaveV3MetisAssets.Metis_UNDERLYING;
  address public constant EMISSION_ADMIN = 0x97177cD80475f8b38945c1E77e12F0c9d50Ac84D;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 7487447);
  }

  function testProposalExecution() public {
    AaveV3_Met_SetEmissionManager_20232607 proposal = new AaveV3_Met_SetEmissionManager_20232607();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Met_SetEmissionManager_20232607',
      AaveV3Metis.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.METIS_BRIDGE_EXECUTOR);

    assertEq(IEmissionManager(AaveV3Metis.EMISSION_MANAGER).getEmissionAdmin(proposal.METIS()), proposal.EMISSION_ADMIN());

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Met_SetEmissionManager_20232607',
      AaveV3Metis.POOL
    );



    e2eTest(AaveV3Metis.POOL);

    diffReports(
      'preAaveV3_Met_SetEmissionManager_20232607',
      'postAaveV3_Met_SetEmissionManager_20232607'
    );
  }
}
