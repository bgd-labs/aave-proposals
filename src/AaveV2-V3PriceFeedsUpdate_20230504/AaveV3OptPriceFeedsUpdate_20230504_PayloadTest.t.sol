// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3OptPriceFeedsUpdate_20230504_Payload} from './AaveV3OptPriceFeedsUpdate_20230504_Payload.sol';

contract AaveV3OptPriceFeedsUpdate_20230425_PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'));
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testPayload() public {
    AaveV3OptPriceFeedsUpdate_20230504_Payload payload = new AaveV3OptPriceFeedsUpdate_20230504_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3OptPriceFeedsUpdate_20230504Change', AaveV3Optimism.POOL);

    // 2. execute payload
    _executePayload(address(payload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3OptPriceFeedsUpdate_20230504_PayloadChange',
      AaveV3Optimism.POOL
    );

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
      AaveV3OptimismAssets.wstETH_UNDERLYING,
      payload.WSTETH_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3OptPriceFeedsUpdate_20230504Change',
      'postAaveV3OptPriceFeedsUpdate_20230504_PayloadChange'
    );
  }
}
