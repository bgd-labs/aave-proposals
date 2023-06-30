// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolCapsUpdates_20230508_Payload} from './AaveV3PolCapsUpdates_20230508_Payload.sol';
import {AaveV3ArbCapsUpdates_20230508_Payload} from './AaveV3ArbCapsUpdates_20230508_Payload.sol';

contract AaveV3PolCapsUpdates_20230508_PayloadTest is ProtocolV3LegacyTestBase {
  AaveV3PolCapsUpdates_20230508_Payload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 42433756);
    payload = new AaveV3PolCapsUpdates_20230508_Payload();
  }

  function testCapsUpdates() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-Aave-V3-Polygon-Caps-Updates-20230508',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig memory stMATIC = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.stMATIC_UNDERLYING
    );

    ReserveConfig memory wstETH = _findReserveConfig(allConfigsBefore, payload.WSTETH_UNDERLYING());

    stMATIC.supplyCap = payload.NEW_SUPPLY_CAP_STMATIC();
    wstETH.supplyCap = payload.NEW_SUPPLY_CAP_WSTETH();

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-Aave-V3-Polygon-Caps-Updates-20230508',
      AaveV3Polygon.POOL
    );

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3PolygonAssets.stMATIC_UNDERLYING;
    assetsChanged[1] = payload.WSTETH_UNDERLYING();

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(stMATIC, allConfigsAfter);
    _validateReserveConfig(wstETH, allConfigsAfter);

    diffReports(
      'pre-Aave-V3-Polygon-Caps-Updates-20230508',
      'post-Aave-V3-Polygon-Caps-Updates-20230508'
    );
  }
}

contract AaveV3ArbCapsUpdates_20230508_PayloadTest is ProtocolV3LegacyTestBase {
  AaveV3ArbCapsUpdates_20230508_Payload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 88408814);
    payload = new AaveV3ArbCapsUpdates_20230508_Payload();
  }

  function testCapsUpdates() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-Aave-V3-Arbitrum-Caps-Updates-20230508',
      AaveV3Arbitrum.POOL
    );

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    ReserveConfig memory wstETH = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.wstETH_UNDERLYING
    );

    wstETH.supplyCap = payload.NEW_SUPPLY_CAP();

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-Aave-V3-Arbitrum-Caps-Updates-20230508',
      AaveV3Arbitrum.POOL
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3ArbitrumAssets.wstETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(wstETH, allConfigsAfter);

    diffReports(
      'pre-Aave-V3-Arbitrum-Caps-Updates-20230508',
      'post-Aave-V3-Arbitrum-Caps-Updates-20230508'
    );
  }
}
