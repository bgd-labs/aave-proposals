// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets, IPoolConfigurator} from 'lib/aave-address-book/src/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'lib/aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IV3RateStrategyFactory} from 'lib/aave-helpers/src/v3-config-engine/IV3RateStrategyFactory.sol';

/**
 * @title sDAI onboarding
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb41600e3f74bfa520549106fee4d21e7f674c5a79fbf1f7ca16947563474a4d7
 * - Discussion: https://governance.aave.com/t/arfc-sdai-aave-v3-onboarding/14410
 */
contract AaveV3_Ethereum_SDAIOnboarding_20230817 is AaveV3PayloadEthereum {
  address public constant sDAI = 0x83F20F44975D03b1b09e64809B757c47f942BEeA;
  address public constant SDAI_PRICE_FEED = 0x29081f7aB5a644716EfcDC10D5c926c5fEe9F72B;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: sDAI,
      assetSymbol: 'sDAI',
      priceFeed: SDAI_PRICE_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(5_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(5_00),
        stableRateSlope2: _bpsToRay(75_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: _bpsToRay(5_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      }),
      enabledToBorrow: EngineFlags.DISABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 77_00,
      liqThreshold: 80_00,
      liqBonus: 4_50,
      reserveFactor: 20_00,
      supplyCap: 340_000_000,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }

  function reserveFactorUpdate() internal {
    IPoolConfigurator(AaveV3Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      20_00
    );
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategy = new IEngine.RateStrategyUpdate[](2);

    rateStrategy[0] = IEngine.RateStrategyUpdate({
      asset: AaveV3EthereumAssets.DAI_UNDERLYING,
      params: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: _bpsToRay(5_00),
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT,
        baseStableRateOffset: EngineFlags.KEEP_CURRENT,
        stableRateExcessOffset:EngineFlags.KEEP_CURRENT,
        optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
      })
    });

    rateStrategy[1] = IEngine.RateStrategyUpdate({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      params: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT,
        baseStableRateOffset: EngineFlags.KEEP_CURRENT,
        stableRateExcessOffset:EngineFlags.KEEP_CURRENT,
        optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategy;
  }
}
