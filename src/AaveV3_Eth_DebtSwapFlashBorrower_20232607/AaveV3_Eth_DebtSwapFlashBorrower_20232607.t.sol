// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Eth_DebtSwapFlashBorrower_20232607} from './AaveV3_Eth_DebtSwapFlashBorrower_20232607.sol';

/**
 * @dev Test for AaveV3_Eth_DebtSwapFlashBorrower_20232607
 * command: make test-contract filter=AaveV3_Eth_DebtSwapFlashBorrower_20232607
 */
contract AaveV3_Eth_DebtSwapFlashBorrower_20232607_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17779664);
  }

  function testProposalExecution() public {
    AaveV3_Eth_DebtSwapFlashBorrower_20232607 proposal = new AaveV3_Eth_DebtSwapFlashBorrower_20232607();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Eth_DebtSwapFlashBorrower_20232607',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Eth_DebtSwapFlashBorrower_20232607',
      AaveV3Ethereum.POOL
    );

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, new address[](0));

    diffReports(
      'preAaveV3_Eth_DebtSwapFlashBorrower_20232607',
      'postAaveV3_Eth_DebtSwapFlashBorrower_20232607'
    );
  }
}
