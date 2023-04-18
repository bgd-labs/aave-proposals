// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title List LDO on AaveV3Ethereum
 * @author Llama
 * @dev This proposal lists LDO on Aave V3 Ethereum
 * Governance: https://governance.aave.com/t/arfc-add-support-for-ldo-on-ethereum-v3/12045
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x953f0edc544fe50e68a0aa19d31542d15458bc3394478a31a294f748198fa906
 */
contract AaveV3Listings_20230403_Payload is AaveV3PayloadEthereum {
  address public constant LDO = 0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32;
  address public constant LDO_PRICE_FEED = 0xb01e6C9af83879B8e06a092f0DD94309c0D497E4;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: LDO,
      assetSymbol: 'LDO',
      priceFeed: LDO_PRICE_FEED,
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
      ltv: 40_00,
      liqThreshold: 50_00,
      liqBonus: 9_00,
      reserveFactor: 20_00,
      supplyCap: 6_000_000,
      borrowCap: 3_000_000,
      debtCeiling: 7_500_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
