// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title AaveV3PolCapsUpdates_20230328
 * @author Llama
 * @dev Update the Aave V3 Polygon wMATIC supply cap, Aave v3 Polygon BAL borrow cap
 * Governance Forum Post: https://governance.aave.com/t/arfc-wmatic-supply-cap-increase/12046
 * Governance Forum Post: https://governance.aave.com/t/arfc-polygon-v3-bal-supply-borrow-cap-increase/12505/3
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb4c756ac701b5cbc0ec2d832652e4f1c820aa40f7d9be18eb81f87080a52c5f1
 */
contract AaveV3PolCapsUpdates_20230328 is AaveV3PayloadPolygon {
  uint256 public constant NEW_SUPPLY_CAP = 66_000_000;
  uint256 public constant NEW_BORROW_CAP = 290_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](2);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.WMATIC_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    capsUpdate[1] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.BAL_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: NEW_BORROW_CAP
    });

    return capsUpdate;
  }
}
