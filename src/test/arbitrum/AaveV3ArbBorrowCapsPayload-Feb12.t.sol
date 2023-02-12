// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Arbitrum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbCapsPayload} from '../../contracts/arbitrum/AaveV3ArbCapsPayload-Feb12.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ArbBorrowCapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3ArbCapsPayload public proposalPayload;

  address public constant WETH = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
  address public constant LINK = 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;

  uint256 public constant WETH_CAP = 35_280;
  uint256 public constant LINK_CAP = 677_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 60237425);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testBorrowCapsArb() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Arbitrum.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3ArbCapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Arbitrum.POOL
    );

    //LINK
    ReserveConfig memory LinkConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, LINK);
    LinkConfig.borrowCap = LINK_CAP;
    ProtocolV3TestBase._validateReserveConfig(LinkConfig, allConfigsAfter);

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, WETH);
    WETHConfig.borrowCap = WETH_CAP;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);
  }
}
