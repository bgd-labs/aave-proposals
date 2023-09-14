// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'lib/aave-address-book/src/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum, IEngine, EngineFlags} from 'lib/aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IV3RateStrategyFactory} from 'lib/aave-helpers/src/v3-config-engine/IV3RateStrategyFactory.sol';

/**
 * @title GHO Borrow Rate Update
 * @author Marc Zeller (@mzeller) - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4b6c0daa24e0268c86ad1aa1a0d3ee32456e6c1ee64aaaab3df4a58a1a0adc04
 * - Discussion: https://governance.aave.com/t/arfc-increase-gho-borrow-rate/14612
 */
contract AaveV3_Ethereum_GHOBorrowRateUpdate_20230904 is AaveV3PayloadEthereum {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategy = new IEngine.RateStrategyUpdate[](1);

    rateStrategy[0] = IEngine.RateStrategyUpdate({
      asset: AaveV3EthereumAssets.GHO_UNDERLYING,
      params: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: _bpsToRay(2_50),
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT,
        baseStableRateOffset: EngineFlags.KEEP_CURRENT,
        stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
        optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
      })
    });
    return rateStrategy;
  }
}