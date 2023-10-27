// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEngine, EngineFlags, Rates} from 'aave-helpers/v3-config-engine/AaveV3PayloadBase.sol';
import {AaveV3PayloadAvalanche, AaveV3AvalancheAssets} from 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';

/**
 * @title MAI/MIMATIC deprecation, 2023.10.23
 * @author Gauntlet
 * - Discussion: https://governance.aave.com/t/arfc-gauntlet-recommendation-for-mai-mimatic-deprecation/15119
 */
contract AaveV3AvalancheUpdate20231024maiPayload is AaveV3PayloadAvalanche {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdates = new IEngine.CollateralUpdate[](1);

    collateralUpdates[0] = IEngine.CollateralUpdate({
      asset: AaveV3AvalancheAssets.MAI_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 0,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdates;
  }

  function borrowsUpdates() public pure override returns (IEngine.BorrowUpdate[] memory) {
    IEngine.BorrowUpdate[] memory borrowUpdates = new IEngine.BorrowUpdate[](1);

    borrowUpdates[0] = IEngine.BorrowUpdate({
      asset: AaveV3AvalancheAssets.MAI_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 9500
    });

    return borrowUpdates;
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategyUpdates = new IEngine.RateStrategyUpdate[](1);

    Rates.RateStrategyParams memory paramsMAI_UNDERLYING = Rates.RateStrategyParams({
      optimalUsageRatio: _bpsToRay(4500),
      baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
      variableRateSlope1: EngineFlags.KEEP_CURRENT,
      variableRateSlope2: _bpsToRay(30000),
      stableRateSlope1: EngineFlags.KEEP_CURRENT,
      stableRateSlope2: EngineFlags.KEEP_CURRENT,
      baseStableRateOffset: EngineFlags.KEEP_CURRENT,
      stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
      optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
    });

    rateStrategyUpdates[0] = IEngine.RateStrategyUpdate({
      asset: AaveV3AvalancheAssets.MAI_UNDERLYING,
      params: paramsMAI_UNDERLYING
    });

    return rateStrategyUpdates;
  }
}
