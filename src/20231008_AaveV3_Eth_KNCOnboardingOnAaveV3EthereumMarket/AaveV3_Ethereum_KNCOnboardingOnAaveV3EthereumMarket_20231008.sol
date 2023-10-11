// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'lib/aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title KNC onboarding on AaveV3 Ethereum market
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: https://signal.aave.com/#/proposal/0xa162335479f27fe1bf4482da63e1f6fa246b0fd770d913d8ba89bd56a5aa644f
 * - Discussion: https://governance.aave.com/t/arfc-knc-onboarding-on-aavev3-ethereum-market/14972
 */
contract AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008 is AaveV3PayloadEthereum {
  address public constant KNC = 0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202;
  address public constant KNC_PRICE_FEED = 0xf8fF43E991A81e6eC886a3D281A2C6cC19aE70Fc;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: KNC,
      assetSymbol: 'KNC',
      priceFeed: KNC_PRICE_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(9_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(13_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: _bpsToRay(5_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 35_00,
      liqThreshold: 40_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 1_200_000,
      borrowCap: 650_000,
      debtCeiling: 1_000_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
