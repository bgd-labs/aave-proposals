// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_MKRDebtCeiling_20230908} from './AaveV3_Ethereum_MKRDebtCeiling_20230908.sol';

/**
 * @dev Test for AaveV3_Ethereum_MKRDebtCeiling_20230908
 * command: make test-contract filter=AaveV3_Ethereum_MKRDebtCeiling_20230908
 */
contract AaveV3_Ethereum_MKRDebtCeiling_20230908_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_MKRDebtCeiling_20230908 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18091606);
    proposal = new AaveV3_Ethereum_MKRDebtCeiling_20230908();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_MKRDebtCeiling_20230908',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_MKRDebtCeiling_20230908',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory MKR_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.MKR_UNDERLYING
    );

    MKR_UNDERLYING_CONFIG.debtCeiling = 6_000_000_00;

    _validateReserveConfig(MKR_UNDERLYING_CONFIG, allConfigsAfter);

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3EthereumAssets.MKR_UNDERLYING
    );

    e2eTestAsset(
      AaveV3Ethereum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.WETH_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.MKR_UNDERLYING)
    );

    diffReports(
      'preAaveV3_Ethereum_MKRDebtCeiling_20230908',
      'postAaveV3_Ethereum_MKRDebtCeiling_20230908'
    );
  }
}
