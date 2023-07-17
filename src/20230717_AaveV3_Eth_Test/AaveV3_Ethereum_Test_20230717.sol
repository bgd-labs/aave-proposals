// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title test
 * @author BGD labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Ethereum_Test_20230717 is AaveV3PayloadEthereum {
  function _postExecute() internal override {}

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategies = new IEngine.RateStrategyUpdate[](1);

    // rateStrategies[0] = IEngine.RateStrategyUpdate({
    //   asset: AaveV3ArbitrumAssets.WETH_UNDERLYING,
    //   params: Rates.RateStrategyParams({
    //     optimalUsageRatio: _bpsToRay(80_00),
    //     baseVariableBorrowRate: _bpsToRay(1_00),
    //     variableRateSlope1: _bpsToRay(3_80),
    //     variableRateSlope2: _bpsToRay(80_00),
    //     stableRateSlope1: _bpsToRay(4_00),
    //     stableRateSlope2: _bpsToRay(80_00),
    //     baseStableRateOffset: _bpsToRay(3_00),
    //     stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
    //     optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
    //   })
    // });

    return rateStrategies;
  }

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    // capsUpdate[0] = IEngine.CapsUpdate({
    //   asset: AaveV3PolygonAssets.EURS_UNDERLYING,
    //   supplyCap: EngineFlags.KEEP_CURRENT,
    //   borrowCap: 1_500_000
    // });

    return capsUpdate;
  }
}
