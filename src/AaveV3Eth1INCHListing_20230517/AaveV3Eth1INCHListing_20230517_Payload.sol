// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title List 1INCH on Aave V3 Ethereum
 * @author ChaosLabs
 * @dev This proposal lists 1INCH on Aave V3 Ethereum
 * Governance: https://governance.aave.com/t/arfc-add-1inch-to-aave-v3-ethereum/13043
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x637d661f1c720aded816291dd01fb093ae8b1b38c322795fae5ceede876a8015
 */
contract AaveV3Eth1INCHListing_20230517_Payload is AaveV3PayloadEthereum {
  address public constant ONEINCH = 0x111111111117dC0aa78b770fA6A738034120C302;
  address public constant ONEINCH_PRICE_FEED = 0xc929ad75B72593967DE83E7F7Cda0493458261D9;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: ONEINCH,
      assetSymbol: '1INCH',
      priceFeed: ONEINCH_PRICE_FEED,
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
      ltv: 57_00,
      liqThreshold: 67_00,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 22_000_000,
      borrowCap: 720_000,
      debtCeiling: 4_500_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
