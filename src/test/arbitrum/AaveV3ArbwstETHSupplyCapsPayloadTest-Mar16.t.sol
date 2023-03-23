// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Arbitrum} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbwstETHCapsPayload} from '../../contracts/arbitrum/AaveV3ArbwstETHSupplyCapsPayload-Mar16.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ArbwstETHCapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3ArbwstETHCapsPayload public proposalPayload;

  address public constant WSTETH = AaveV3ArbitrumAssets.wstETH_UNDERLYING;

  uint256 public constant WSTETH_SUPPLY_CAP = 4_650;
  uint256 public constant WSTETH_BORROW_CAP = 400;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 70484586);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testSupplyCapsArb() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Arbitrum.POOL);

    //WSTETH
    ReserveConfig memory wtsethConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      WSTETH
    );
    wtsethConfig.supplyCap = WSTETH_SUPPLY_CAP;
    wtsethConfig.borrowCap = WSTETH_BORROW_CAP;

    // 1. deploy l2 payload
    proposalPayload = new AaveV3ArbwstETHCapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Arbitrum.POOL
    );

    ProtocolV3TestBase._validateReserveConfig(wtsethConfig, allConfigsAfter);
  }
}
