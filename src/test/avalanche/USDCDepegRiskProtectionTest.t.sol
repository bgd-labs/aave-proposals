// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {USDCDepegRiskProtection} from '../../contracts/avalanche/USDCDepegRiskProtection.sol';

contract USDCDepegRiskProtectionTest is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 27294340);
    _selectPayloadExecutor(0xa35b76E4935449E33C56aB24b23fcd3246f13470); // guardian
  }

  function testChanges() public {
    createConfigurationSnapshot('pre-USDCProtection-Payload', AaveV3Avalanche.POOL);

    _executePayload(address(new USDCDepegRiskProtection()));

    createConfigurationSnapshot('post-USDCProtection-Payload', AaveV3Avalanche.POOL);

    diffReports('pre-USDCProtection-Payload', 'post-USDCProtection-Payload');
  }
}
