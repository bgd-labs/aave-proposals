// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolConfigurator} from 'lib/aave-address-book/src/AaveV2Ethereum.sol';
import 'lib/aave-helpers/src/v2-config-engine/AaveV2PayloadEthereum.sol';

/**
 * @title Aave V2 DAI Parameters Updates
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb41600e3f74bfa520549106fee4d21e7f674c5a79fbf1f7ca16947563474a4d7
 * - Discussion: https://governance.aave.com/t/arfc-sdai-aave-v3-onboarding/14410
 */
contract AaveV2_Ethereum_DAIParamsUpdates_20230817 is AaveV2PayloadEthereum {
  function _postExecute() internal override {
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      25_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.DAI_UNDERLYING);
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategy = new IEngine.RateStrategyUpdate[](1);

    rateStrategy[0] = IEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.DAI_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: _bpsToRay(5_00),
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategy;
  }
}
