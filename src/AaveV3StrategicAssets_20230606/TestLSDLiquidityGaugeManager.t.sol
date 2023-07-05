// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

import {ILiquidityGaugeController} from './interfaces/ILiquidityGauge.sol';
import {LSDLiquidityGaugeManager} from './LSDLiquidityGaugeManager.sol';
import {StrategicAssetsManager} from './StrategicAssetsManager.sol';
import {Core} from './Core.sol';

interface ISmartWalletChecker {
  function allowlistAddress(address contractAddress) external;
}

contract LSDLiquidityGaugeManagerTest is Test {
    event GaugeControllerChanged(address indexed oldController, address indexed newController);

    // Helpers
    address public constant SMART_WALLET_CHECKER = 0x7869296Efd0a76872fEE62A058C8fBca5c1c826C;

    address public constant B_80BAL_20WETH = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;
    address public constant VE_BAL = 0xC128a9954e6c874eA3d62ce62B468bA073093F25;
    address public constant VE_BAL_GAUGE = 0x27Fd581E9D0b2690C2f808cd40f7fe667714b575;
    address public constant WARDEN_VE_BAL = 0x42227bc7D65511a357c43993883c7cef53B25de9;
    address public constant BALANCER_GAUGE_CONTROLLER = 0xC128468b7Ce63eA702C1f104D55A2566b13D3ABD;
    address public constant STAKE_DAO_GAUGE_CONTROLLER = 0x75f8f7fa4b6DA6De9F4fE972c811b778cefce882;

    StrategicAssetsManager public strategicAssets;

    function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17523941);

    strategicAssets = new StrategicAssetsManager();
    strategicAssets.initialize();
  }

  function _addVeToken(
    address underlying,
    address veToken,
    address warden,
    uint256 lockDuration,
    address delegate,
    bytes32 spaceId
  ) internal {
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addVeToken(underlying, veToken, warden, lockDuration, delegate, spaceId);
    vm.stopPrank();
  }
}

contract SetGaugeController is LSDLiquidityGaugeManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.setGaugeController(B_80BAL_20WETH, BALANCER_GAUGE_CONTROLLER);
  }

  function test_revertsIf_invalid0xAddress() public {
    vm.expectRevert(Core.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setGaugeController(B_80BAL_20WETH, address(0));
    vm.stopPrank();
  }

  function test_revertsIf_settingToSameController() public {
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setGaugeController(B_80BAL_20WETH, BALANCER_GAUGE_CONTROLLER);

    vm.expectRevert(LSDLiquidityGaugeManager.SameController.selector);
    strategicAssets.setGaugeController(B_80BAL_20WETH, BALANCER_GAUGE_CONTROLLER);
    vm.stopPrank();
  }

  function test_successful() public {
    vm.expectEmit();
    emit GaugeControllerChanged(address(0), BALANCER_GAUGE_CONTROLLER);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setGaugeController(B_80BAL_20WETH, BALANCER_GAUGE_CONTROLLER);
    vm.stopPrank();

    assertEq(strategicAssets.gaugeControllers(B_80BAL_20WETH), BALANCER_GAUGE_CONTROLLER);
  }
}

contract VoteForGaugeWeight is LSDLiquidityGaugeManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.voteForGaugeWeight(VE_BAL, VE_BAL_GAUGE, 100);
  }

  function test_revertsIf_gaugeIsZeroAddress() public {
    vm.expectRevert(Core.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.voteForGaugeWeight(VE_BAL, address(0), 100);
    vm.stopPrank();
  }

  function test_successful() public {
    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, 365 * 86400, address(0), '');

    vm.startPrank(0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f); // Authenticated Address
    ISmartWalletChecker(SMART_WALLET_CHECKER).allowlistAddress(address(strategicAssets));
    vm.stopPrank();

    deal(B_80BAL_20WETH, address(strategicAssets), 1_000e18);

    uint256 weightBefore = ILiquidityGaugeController(BALANCER_GAUGE_CONTROLLER).get_gauge_weight(VE_BAL_GAUGE);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);
    strategicAssets.setGaugeController(B_80BAL_20WETH, BALANCER_GAUGE_CONTROLLER);
    strategicAssets.voteForGaugeWeight(B_80BAL_20WETH, VE_BAL_GAUGE, 100);
    vm.stopPrank();

    assertGt(ILiquidityGaugeController(BALANCER_GAUGE_CONTROLLER).get_gauge_weight(VE_BAL_GAUGE), weightBefore);
  }
}

contract StakeInGauge is LSDLiquidityGaugeManagerTest {

}

contract UnstakeFromGauge is LSDLiquidityGaugeManagerTest {

}

contract ClaimGaugeRewards is LSDLiquidityGaugeManagerTest {

}
