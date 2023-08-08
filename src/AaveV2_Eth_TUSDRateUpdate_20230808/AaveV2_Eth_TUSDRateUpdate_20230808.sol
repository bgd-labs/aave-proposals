// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2PayloadEthereum, IEngine, EngineFlags} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IV2RateStrategyFactory} from 'lib/aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';


/**
 * @title TUSD rate update
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xfd0cdbf58992759f47e6f5a6c07cbeb2b1a02af1c9ebf7d3099b80c33f53c138
 * - Discussion: https://governance.aave.com/t/arfc-tusd-offboarding-plan/14008
 */
contract AaveV2_Eth_TUSDRateUpdate_20230808 is AaveV2PayloadEthereum {

    function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {

    IEngine.RateStrategyUpdate[] memory rateStrategy = new IEngine.RateStrategyUpdate[](1);

    rateStrategy[0] = IEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.TUSD_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(200_00)
      })
    });

    
    return rateStrategy;
  }
}