// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadOptimism, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';

/**
 * @title OP Risk Parameters Update
 * @author Marc Zeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x617adb838ce95e319f06f72e177ad62cd743c2fe3fd50d6340dfc8606fbdd0b3
 * - Discussion: https://governance.aave.com/t/arfc-op-risk-parameters-update-aave-v3-optimism-pool/14633
 */
contract AaveV3_Optimism_OPRiskParametersUpdate_20230924 is AaveV3PayloadOptimism {

  
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.OP_UNDERLYING,
      ltv: 30_00,
      liqThreshold: 40_00,
      liqBonus: 10_00,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });
    return collateralUpdate;
  }

  function rateStrategiesUpdates()
    public
    view
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory ratesUpdate = new IEngine.RateStrategyUpdate[](1);

    ratesUpdate[0] = IEngine.RateStrategyUpdate({
      asset: AaveV3OptimismAssets.OP_UNDERLYING,
      params: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(7_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(7_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
        optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
      })
    });

    return ratesUpdate;
  }
}
