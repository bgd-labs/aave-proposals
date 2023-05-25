// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthPriceFeedsUpdate_20230504_Payload} from './AaveV3EthPriceFeedsUpdate_20230504_Payload.sol';

contract AaveV3EthPriceFeedsUpdate_20230504_PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17336065);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPayload() public {
    AaveV3EthPriceFeedsUpdate_20230504_Payload payload = new AaveV3EthPriceFeedsUpdate_20230504_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3EthPriceFeedsUpdate_20230504Change', AaveV3Ethereum.POOL);

    // 2. execute payload
    _executePayload(address(payload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3EthPriceFeedsUpdate_20230504_PayloadChange',
      AaveV3Ethereum.POOL
    );

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV3EthereumAssets.cbETH_UNDERLYING,
      payload.CBETH_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3EthPriceFeedsUpdate_20230504Change',
      'postAaveV3EthPriceFeedsUpdate_20230504_PayloadChange'
    );
  }
}
