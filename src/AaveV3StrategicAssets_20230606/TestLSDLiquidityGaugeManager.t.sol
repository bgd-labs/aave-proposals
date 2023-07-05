// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

import {LSDLiquidityGaugeManager} from './LSDLiquidityGaugeManager.sol';
import {StrategicAssetsManager} from './StrategicAssetsManager.sol';
import {Core} from './Core.sol';

contract LSDLiquidityGaugeManagerTest is Test {
    event GaugeControllerChanged(address indexed oldController, address indexed newController);

    address public constant B_80BAL_20WETH = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;
    address public constant BALANCER_GAUGE_CONTROLLER = 0xC128468b7Ce63eA702C1f104D55A2566b13D3ABD;
    address public constant STAKE_DAO_GAUGE_CONTROLLER = 0x75f8f7fa4b6DA6De9F4fE972c811b778cefce882;

    StrategicAssetsManager public strategicAssets;

    function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17523941);

    strategicAssets = new StrategicAssetsManager();
    strategicAssets.initialize();
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

}

contract StakeInGauge is LSDLiquidityGaugeManagerTest {

}

contract UnstakeFromGauge is LSDLiquidityGaugeManagerTest {

}

contract ClaimGaugeRewards is LSDLiquidityGaugeManagerTest {

}
