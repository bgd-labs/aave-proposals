// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3PayloadOptimism, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';

/**
 * @title This proposal updates MAI Supply/Borrow Caps and Debt Ceiling on Aave V3
 * @author @yonikesel - ChaosLabsInc
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-mai-on-aave-v3-2023-7-23/14110
 */
contract AaveV3OptMAICapsUpdates_20230724 is AaveV3PayloadOptimism {
  uint256 public constant NEW_SUPPLY_CAP_MAI = 650_000;
  uint256 public constant NEW_BORROW_CAP_MAI = 525_000;
  uint256 public constant NEW_DEBT_CEILING_MAI = 130_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3OptimismAssets.MAI_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP_MAI,
      borrowCap: NEW_BORROW_CAP_MAI
    });

    return capsUpdate;
  }

  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.MAI_UNDERLYING,
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
