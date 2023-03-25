// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3OptLUSDPayload} from '../../contracts/optimism/AaveV3OptLUSDPayload.sol';

contract AaveV3OptLUSDPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 83575825);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testPoolActivation() public {
    AaveV3OptLUSDPayload LUSD = new AaveV3OptLUSDPayload();

    createConfigurationSnapshot('preLUSD', AaveV3Optimism.POOL);

    _executePayload(address(LUSD));

    createConfigurationSnapshot('postLUSD', AaveV3Optimism.POOL);

    diffReports('preLUSD', 'postLUSD');
  }
}
