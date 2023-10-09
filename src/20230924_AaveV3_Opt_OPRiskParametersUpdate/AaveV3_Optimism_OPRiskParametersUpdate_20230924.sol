// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadOptimism, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title OP Risk Parameters Update
 * @author Marc Zeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x617adb838ce95e319f06f72e177ad62cd743c2fe3fd50d6340dfc8606fbdd0b3
 * - Discussion: https://governance.aave.com/t/arfc-op-risk-parameters-update-aave-v3-optimism-pool/14633
 */
contract AaveV3_Optimism_OPRiskParametersUpdate_20230924 is AaveV3PayloadOptimism {
  uint256 public constant BORROW_CAP = 500_000;
  uint256 public constant DEBT_CEILING = 0;

  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.OP_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: DEBT_CEILING,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });
    return collateralUpdate;
  }

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3OptimismAssets.OP_UNDERLYING,
      borrowCap: BORROW_CAP,
      supplyCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
