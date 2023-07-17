// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_Test_20230717} from './AaveV3_Ethereum_Test_20230717.sol';

/**
 * @dev Test for AaveV3_Ethereum_Test_20230717
 * command: make test-contract filter=AaveV3_Ethereum_Test_20230717
 */
contract AaveV3_Ethereum_Test_20230717_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17713929);
  }

  function testProposalExecution() public {
    AaveV3_Ethereum_Test_20230717 proposal = new AaveV3_Ethereum_Test_20230717();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_Test_20230717',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_Test_20230717',
      AaveV3Ethereum.POOL
    );

    diffReports('preAaveV3_Ethereum_Test_20230717', 'postAaveV3_Ethereum_Test_20230717');
  }
}