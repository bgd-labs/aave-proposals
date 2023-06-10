// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title List rETH on Aave V3 Arbitrum
 * @author Llama
 * @dev This proposal lists rETH on Aave V3 Arbitrum
 * Governance: https://governance.aave.com/t/arfc-add-reth-to-aave-v3-arbitrum-liquidity-pool/12810
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xa7bc42ca1f658655e9998d22d616133da734bad0e6caae9c7d016ad97abf1451
 */
contract AaveV3ArbListings_20230524_Payload is AaveV3PayloadArbitrum {
  address public constant RETH = 0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8;
  address public constant RETH_PRICE_FEED = 0x04c28D6fE897859153eA753f986cc249Bf064f71;

  function newListingsCustom() public pure override returns (IEngine.ListingWithCustomImpl[] memory) {
    IEngine.ListingWithCustomImpl[] memory listings = new IEngine.ListingWithCustomImpl[](1);

    listings[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
      asset: RETH,
      assetSymbol: 'rETH',
      priceFeed: RETH_PRICE_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(7_00),
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
      ltv: 67_00,
      liqThreshold: 74_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 325,
      borrowCap: 85,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 0
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