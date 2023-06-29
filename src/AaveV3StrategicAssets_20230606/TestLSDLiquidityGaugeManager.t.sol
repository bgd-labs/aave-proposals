// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';

import {StrategicAssetsManager} from './StrategicAssetsManager.sol';
import {Core} from './Core.sol';

contract LSDLiquidityGaugeManagerTest is Test {
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

}

contract VoteForGaugeWeight is LSDLiquidityGaugeManagerTest {

}

contract StakeInGauge is LSDLiquidityGaugeManagerTest {

}

contract UnstakeFromGauge is LSDLiquidityGaugeManagerTest {

}

contract ClaimGaugeRewards is LSDLiquidityGaugeManagerTest {

}
