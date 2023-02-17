// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3OPWSTETHPayload} from '../../contracts/optimism/AaveV3OPWSTETHPayload.sol';

contract AaveV3OPWSTETHPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 75011919);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testPoolActivation() public {
    AaveV3OPWSTETHPayload WSTETH = new AaveV3OPWSTETHPayload();

    createConfigurationSnapshot('preWSTETH', AaveV3Optimism.POOL);

    _executePayload(address(WSTETH));

    createConfigurationSnapshot('postWSTETH', AaveV3Optimism.POOL);

    diffReports('preWSTETH', 'postWSTETH');
  }
}
