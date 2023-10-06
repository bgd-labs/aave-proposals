// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2PayloadEthereum, IEngine, EngineFlags, Rates} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Test Proposal
 * @author BGD labs
 * - Snapshot: yay
 * - Discussion: https://link
 */
contract AaveV2Ethereum_TestProposal_20231006 is AaveV2PayloadEthereum {
  function _preExecute() internal override {}

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategies = new IEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.WETH_UNDERLYING,
      params: Rates.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(10_00),
        baseVariableBorrowRate: _bpsToRay(1000_00),
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
