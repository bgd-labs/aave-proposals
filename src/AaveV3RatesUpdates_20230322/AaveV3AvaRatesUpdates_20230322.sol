// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3PayloadAvalanche, IEngine, EngineFlags, Rates} from 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';

/**
 * @title AaveV3AvaRatesUpdates_20230322
 * @author Llama
 * @dev Amend the wAVAX interest rate parameters on the Aave Avalanche v3 Liquidity Pool.
 * Governance Forum Post: https://governance.aave.com/t/arfc-avalanche-wavax-interest-rate-upgrade/11561
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x08a9c7f13a3970cf9754ca52da51ca05d8baad8dc30927a2752344577b167f09
 */
contract AaveV3AvaRatesUpdates_20230322 is AaveV3PayloadAvalanche {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory ratesUpdate = new IEngine.RateStrategyUpdate[](1);

    ratesUpdate[0] = IEngine.RateStrategyUpdate({
      asset: AaveV3AvalancheAssets.WAVAX_UNDERLYING,
      params: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(65_00),
        baseVariableBorrowRate: _bpsToRay(1_00),
        variableRateSlope1: _bpsToRay(4_72),
        variableRateSlope2: _bpsToRay(144_28),
        stableRateSlope1: _bpsToRay(4_72),
        stableRateSlope2: _bpsToRay(144_28),
        baseStableRateOffset: _bpsToRay(4_00),
        stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
        optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
      })
    });

    return ratesUpdate;
  }
}
