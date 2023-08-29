// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3PayloadOptimism, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';

/**
 * @title Chaos Labs Risk Parameter Updates - Aave V3 Optimism - 2023.08.13
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x7568e17d2d7078686255a8fadf563e1f072abae0b79188a5b5b76852a6ebd63f
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-optimism-2023-08-13/14466
 */
contract AaveV3_Opt_RiskParamsUpdate_20232408 is AaveV3PayloadOptimism {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](2);

    // WBTC
    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.WBTC_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: 7_50,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    // wstETH
    collateralUpdate[1] = IEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.wstETH_UNDERLYING,
      ltv: 71_00,
      liqThreshold: 80_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
