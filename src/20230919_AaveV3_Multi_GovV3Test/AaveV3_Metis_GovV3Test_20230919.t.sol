// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Metis_GovV3Test_20230919} from './AaveV3_Metis_GovV3Test_20230919.sol';

/**
 * @dev Test for AaveV3_Metis_GovV3Test_20230919
 * command: make test-contract filter=AaveV3_Metis_GovV3Test_20230919
 */
contract AaveV3_Metis_GovV3Test_20230919_Test is ProtocolV3TestBase {
  AaveV3_Metis_GovV3Test_20230919 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 8622689);
    proposal = new AaveV3_Metis_GovV3Test_20230919();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Metis_GovV3Test_20230919',
      AaveV3Metis.POOL
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Metis_GovV3Test_20230919',
      AaveV3Metis.POOL
    );

    diffReports('preAaveV3_Metis_GovV3Test_20230919', 'postAaveV3_Metis_GovV3Test_20230919');
  }
}
