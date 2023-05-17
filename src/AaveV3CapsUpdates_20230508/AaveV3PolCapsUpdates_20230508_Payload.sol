// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title AaveV3PolCapsUpdates_20230508_Payload
 * @author Llama
 * @dev Update the Aave V3 Polygon stMATIC and wstETH supply caps
 * Forum stMATIC: https://governance.aave.com/t/arfc-increase-stmatic-supplycap/12998
 * Forum wstETH: https://governance.aave.com/t/arfc-increase-wsteth-supply-cap-on-polygon-v3/12971
 */
contract AaveV3PolCapsUpdates_20230508_Payload is AaveV3PayloadPolygon {
  uint256 public constant NEW_SUPPLY_CAP_WSTETH = 2_400;
  uint256 public constant NEW_SUPPLY_CAP_STMATIC = 30_000_000;
  address public constant WSTETH_UNDERLYING = 0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](2);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: WSTETH_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP_WSTETH,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    capsUpdate[1] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.stMATIC_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP_STMATIC,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
