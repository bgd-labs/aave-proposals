// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV2EthereumAMM, AaveV2EthereumAMMAssets} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2EthereumAMM_Test_20230926} from './AaveV2EthereumAMM_Test_20230926.sol';

/**
 * @dev Test for AaveV2EthereumAMM_Test_20230926
 * command: make test-contract filter=AaveV2EthereumAMM_Test_20230926
 */
contract AaveV2EthereumAMM_Test_20230926_Test is ProtocolV2TestBase {
  AaveV2EthereumAMM_Test_20230926 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18220390);
    proposal = new AaveV2EthereumAMM_Test_20230926();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2EthereumAMM_Test_20230926',
      AaveV2EthereumAMM.POOL
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2EthereumAMM_Test_20230926',
      AaveV2EthereumAMM.POOL
    );

    diffReports('preAaveV2EthereumAMM_Test_20230926', 'postAaveV2EthereumAMM_Test_20230926');
  }
}
