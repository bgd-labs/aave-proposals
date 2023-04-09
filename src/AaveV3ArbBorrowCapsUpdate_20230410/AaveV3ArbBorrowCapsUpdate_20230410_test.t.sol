// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbBorrowCapsUpdate_20230410} from './AaveV3ArbBorrowCapsUpdate_20230410.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ArbBorrowCapsUpdate_20230410_Test is ProtocolV3TestBase, TestWithExecutor {
  AaveV3ArbBorrowCapsUpdate_20230410 public proposalPayload;

  uint256 public constant WSTETH_BORROW_CAP = 800;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 78522683);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testBorrowCapsArb() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Arbitrum.POOL);

    createConfigurationSnapshot(
      'preAaveV3ArbBorrowCapsUpdate_20230410Change',
      AaveV3Arbitrum.POOL
    );

    proposalPayload = new AaveV3ArbBorrowCapsUpdate_20230410();

    _executePayload(address(proposalPayload));

    createConfigurationSnapshot(
      'postAaveV3ArbBorrowCapsUpdate_20230410Change',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory wstethConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.wstETH_UNDERLYING
    );
    wstethConfig.borrowCap = WSTETH_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(wstethConfig, allConfigsAfter);

    diffReports(
      'preAaveV3ArbBorrowCapsUpdate_20230410Change',
      'postAaveV3ArbBorrowCapsUpdate_20230410Change'
    );
  }
}
