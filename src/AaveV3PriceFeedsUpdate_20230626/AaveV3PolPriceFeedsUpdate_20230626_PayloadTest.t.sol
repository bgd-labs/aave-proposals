// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolPriceFeedsUpdate_20230626_Payload} from './AaveV3PolPriceFeedsUpdate_20230626_Payload.sol';

contract AaveV3PolPriceFeedsUpdate_20230626_PayloadTest is ProtocolV3LegacyTestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 44448455);
  }

  function testPayload() public {
    AaveV3PolPriceFeedsUpdate_20230626_Payload payload = new AaveV3PolPriceFeedsUpdate_20230626_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot(
      'preAaveV3PolPriceFeedsUpdate_20230626_PayloadChange',
      AaveV3Polygon.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    // 3. create snapshot after payload execution
    ReserveConfig[] memory configs = createConfigurationSnapshot(
      'postAaveV3PolPriceFeedsUpdate_20230626_PayloadChange',
      AaveV3Polygon.POOL
    );

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      AaveV3PolygonAssets.wstETH_UNDERLYING,
      payload.WSTETH_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3PolPriceFeedsUpdate_20230626_PayloadChange',
      'postAaveV3PolPriceFeedsUpdate_20230626_PayloadChange'
    );

    // 6. e2e
    e2eTestAsset(
      AaveV3Polygon.POOL,
      _findReserveConfig(configs, AaveV3PolygonAssets.DAI_UNDERLYING),
      _findReserveConfig(configs, AaveV3PolygonAssets.wstETH_UNDERLYING)
    );
  }
}
