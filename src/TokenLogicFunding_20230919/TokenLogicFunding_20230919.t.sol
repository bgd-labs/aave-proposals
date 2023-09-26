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
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18219942);
  }

  function testpayload() public {

    address TOKENLOGIC = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;
    address GHO_WHALE = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    uint256 STREAM_ID = 100012;
    uint256 AMOUNT = 350_000 * 1e18;
    uint256 STREAM_DURATION = 180 days;
    uint256 ACTUAL_STREAM_AMOUNT = (AMOUNT / STREAM_DURATION) * STREAM_DURATION;

    TokenLogicFunding_20230919 payload = TokenLogicFunding_20230919(0xE5Cac83F10F9eed3fe1575AEe87DE030815F1d83);
    
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(TOKENLOGIC);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    // milkman creates intermediary contract for each swap
    // while swap is not executed the assets will be in these swap-specific proxy addresses instead of aaveSwapper
    // proxy contracts addresses are deterministic, they could be derived via code. 
    // I simulated execution and copy pasted the address for simplicity
    // see https://etherscan.io/address/0x11C76AD590ABDFFCD980afEC9ad951B160F02797#code#L878
    address swapProxy = 0x2414B7eDd549E62e8a5877b73D96C80bAbC30bca;
    uint256 daiAmount = 350_000 * 1e18;
    uint256 proxyBalanceAfter = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(swapProxy);
    assertEq(proxyBalanceAfter, daiAmount);

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
