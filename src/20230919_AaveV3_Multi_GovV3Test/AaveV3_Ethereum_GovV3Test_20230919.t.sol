// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_GovV3Test_20230919} from './AaveV3_Ethereum_GovV3Test_20230919.sol';

/**
 * @dev Test for AaveV3_Ethereum_GovV3Test_20230919
 * command: make test-contract filter=AaveV3_Ethereum_GovV3Test_20230919
 */
contract AaveV3_Ethereum_GovV3Test_20230919_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_GovV3Test_20230919 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18170582);
    proposal = new AaveV3_Ethereum_GovV3Test_20230919();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_GovV3Test_20230919',
      AaveV3Ethereum.POOL
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_GovV3Test_20230919',
      AaveV3Ethereum.POOL
    );

    diffReports('preAaveV3_Ethereum_GovV3Test_20230919', 'postAaveV3_Ethereum_GovV3Test_20230919');
  }
}
