// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2PriceFeedsUpdate_20230425_Payload} from './AaveV2PriceFeedsUpdate_20230425_Payload.sol';

contract AaveV2PriceFeedsUpdate_20230425_PayloadTest is ProtocolV2TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17122470);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPayload() public {
    AaveV2PriceFeedsUpdate_20230425_Payload payload = new AaveV2PriceFeedsUpdate_20230425_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV2PriceFeedsUpdate_20230425Change', AaveV2Ethereum.POOL);

    // 2. execute payload
    _executePayload(address(payload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot('postAaveV2PriceFeedsUpdate_20230425Change', AaveV2Ethereum.POOL);

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV2Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV2EthereumAssets.WBTC_UNDERLYING,
      payload.WBTC_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV2PriceFeedsUpdate_20230425Change',
      'postAaveV2PriceFeedsUpdate_20230425Change'
    );
  }
}
