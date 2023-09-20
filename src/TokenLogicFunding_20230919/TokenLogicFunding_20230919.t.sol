// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {TokenLogicFunding_20230919} from './TokenLogicFunding_20230919.sol';

contract TokenLogicFunding_20230919_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18166945);
  }

  function testpayload() public {

    address TOKENLOGIC = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;
    address GHO_WHALE = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    uint256 STREAM_ID = 100012;
    uint256 AMOUNT = 350_000 * 1e18;
    uint256 STREAM_DURATION = 180 days;
    uint256 ACTUAL_STREAM_AMOUNT = (AMOUNT / STREAM_DURATION) * STREAM_DURATION;

    TokenLogicFunding_20230919 payload = new TokenLogicFunding_20230919();
    
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(TOKENLOGIC);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    /// check if can withdraw from stream & pretend the swap happened
    vm.warp(block.timestamp + 180 days + 1);

    vm.prank(GHO_WHALE);
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).transfer(address(AaveV3Ethereum.COLLECTOR), ACTUAL_STREAM_AMOUNT);
    
    vm.prank(TOKENLOGIC);
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(STREAM_ID, ACTUAL_STREAM_AMOUNT);
    
    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(TOKENLOGIC);
    assertEq(balanceAfter, balanceBefore + ACTUAL_STREAM_AMOUNT);
  }
}
