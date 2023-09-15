// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_GHOBorrowRateUpdate_20230904} from './AaveV3_Ethereum_GHOBorrowRateUpdate_20230904.sol';

/**
 * @dev Test for AaveV3_Ethereum_GHOBorrowRateUpdate_20230904
 * command: make test-contract filter=AaveV3_Ethereum_GHOBorrowRateUpdate_20230904
 */
contract AaveV3_Ethereum_GHOBorrowRateUpdate_20230904_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_GHOBorrowRateUpdate_20230904 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18141094);
    proposal = new AaveV3_Ethereum_GHOBorrowRateUpdate_20230904();
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3_Ethereum_GHOBorrowRateUpdate_20230904',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_GHOBorrowRateUpdate_20230904',
      AaveV3Ethereum.POOL
    );

    e2eTestAsset(
      AaveV3Ethereum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.USDC_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.GHO_UNDERLYING)
    );

    diffReports(
      'preAaveV3_Ethereum_GHOBorrowRateUpdate_20230904',
      'postAaveV3_Ethereum_GHOBorrowRateUpdate_20230904'
    );
  }
}
