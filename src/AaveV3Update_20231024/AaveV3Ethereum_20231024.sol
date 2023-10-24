// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEngine,EngineFlags,Rates} from 'aave-helpers/v3-config-engine/AaveV3PayloadBase.sol';
import {
  AaveV3PayloadEthereum,
  AaveV3EthereumAssets
} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
  * @title Upgrade Aave V3 ETH pool wETH parameters
  * @author Gauntlet, ACI
  * - Discussion: https://governance.aave.com/t/arfc-upgrade-aave-v3-eth-pool-weth-parameters/15110
 */
contract AaveV3EthereumUpdate20231024Payload is AaveV3PayloadEthereum {
  function rateStrategiesUpdates() public pure override returns (IEngine.RateStrategyUpdate[] memory) {
    IEngine.RateStrategyUpdate[] memory rateStrategyUpdates = new IEngine.RateStrategyUpdate[](1);

    Rates.RateStrategyParams memory paramsWETH_UNDERLYING = Rates.RateStrategyParams({
      optimalUsageRatio: _bpsToRay(8000),
      baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
      variableRateSlope1: _bpsToRay(280),
      variableRateSlope2: EngineFlags.KEEP_CURRENT,
      stableRateSlope1: EngineFlags.KEEP_CURRENT,
      stableRateSlope2: EngineFlags.KEEP_CURRENT,
      baseStableRateOffset: EngineFlags.KEEP_CURRENT,
      stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
      optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
    });

    rateStrategyUpdates[0] = IEngine.RateStrategyUpdate({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      params: paramsWETH_UNDERLYING
    });

    return rateStrategyUpdates;
  }
}