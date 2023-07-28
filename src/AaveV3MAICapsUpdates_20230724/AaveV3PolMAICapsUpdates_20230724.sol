// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title This proposal updates MAI Supply/Borrow Caps and Debt Ceiling on Aave V3
 * @author @yonikesel - ChaosLabsInc
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-mai-on-aave-v3-2023-7-23/14110
 */
contract AaveV3PolMAICapsUpdates_20230724 is AaveV3PayloadPolygon {
  uint256 public constant NEW_SUPPLY_CAP_MAI = 900_000;
  uint256 public constant NEW_BORROW_CAP_MAI = 700_000;
  uint256 public constant NEW_DEBT_CEILING_MAI = 180_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.miMATIC_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP_MAI,
      borrowCap: NEW_BORROW_CAP_MAI
    });

    return capsUpdate;
  }

  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.miMATIC_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: NEW_DEBT_CEILING_MAI,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
