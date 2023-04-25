// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbPriceFeedsUpdate_20230425_Payload} from './AaveV3ArbPriceFeedsUpdate_20230425_Payload.sol';

contract AaveV3ArbPriceFeedsUpdate_20230425_PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'));
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testPayload() public {
    AaveV3ArbPriceFeedsUpdate_20230425_Payload payload = new AaveV3ArbPriceFeedsUpdate_20230425_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3ArbPriceFeedsUpdate_20230425Change', AaveV3Arbitrum.POOL);

    // 2. execute payload
    _executePayload(address(payload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3ArbPriceFeedsUpdate_20230425_PayloadChange',
      AaveV3Arbitrum.POOL
    );

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      payload.WSTETH_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3ArbPriceFeedsUpdate_20230425Change',
      'postAaveV3ArbPriceFeedsUpdate_20230425_PayloadChange'
    );
  }
}
