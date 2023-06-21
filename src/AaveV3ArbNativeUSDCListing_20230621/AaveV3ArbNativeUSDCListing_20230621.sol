// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title Add Native USDC on Aave V3 Arbitrum
 * @author @marczeller - Aave-Chan Initiative
 * @dev This proposal onboard Native USDC on Aave V3 Arbitrum
 * Governance: https://governance.aave.com/t/arfc-add-native-usdc-to-the-arbitrum-v3-pool/13568
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x8c8da3842a4590f609b2781874b740808170bd8e37a3589bb6b5af8df6c9c153
 */
contract AaveV3ArbNativeUSDCListing_20230621 is AaveV3PayloadArbitrum {
  address public constant USDCN = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
  address public constant USDCN_PRICE_FEED = 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3;

  function newListingsCustom()
    public
    pure
    override
    returns (IEngine.ListingWithCustomImpl[] memory)
  {
    IEngine.ListingWithCustomImpl[] memory listings = new IEngine.ListingWithCustomImpl[](1);

    listings[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
        asset: USDCN,
        assetSymbol: 'USDCn',
        priceFeed: USDCN_PRICE_FEED,
        rateStrategyParams: Rates.RateStrategyParams({
          optimalUsageRatio: _bpsToRay(90_00),
          baseVariableBorrowRate: 0,
          variableRateSlope1: _bpsToRay(3_50),
          variableRateSlope2: _bpsToRay(60_00),
          stableRateSlope1: _bpsToRay(5_00),
          stableRateSlope2: _bpsToRay(60_00),
          baseStableRateOffset: _bpsToRay(1_00),
          stableRateExcessOffset: _bpsToRay(8_00),
          optimalStableToTotalDebtRatio: _bpsToRay(20_00)
        }),
        enabledToBorrow: EngineFlags.ENABLED,
        stableRateModeEnabled: EngineFlags.DISABLED,
        borrowableInIsolation: EngineFlags.ENABLED,
        withSiloedBorrowing: EngineFlags.DISABLED,
        flashloanable: EngineFlags.ENABLED,
        ltv: 81_00,
        liqThreshold: 86_00,
        liqBonus: 5_00,
        reserveFactor: 10_00,
        supplyCap: 41_000_000,
        borrowCap: 41_000_000,
        debtCeiling: 0,
        liqProtocolFee: 10_00,
        eModeCategory: 1
      }),
      IEngine.TokenImplementations({
        aToken: AaveV3Arbitrum.DEFAULT_A_TOKEN_IMPL_REV_2,
        vToken: AaveV3Arbitrum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
        sToken: AaveV3Arbitrum.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_2
      })
    );

    return listings;
  }
}
