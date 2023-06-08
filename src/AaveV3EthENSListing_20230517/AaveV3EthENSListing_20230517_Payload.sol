// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title List ENS on Aave V3 Ethereum
 * @author ChaosLabs
 * @dev This proposal lists ENS on Aave V3 Ethereum
 * Governance: https://governance.aave.com/t/arfc-add-ens-to-aave-v3-ethereum/13044
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xd33381a83222b33afa8277f86fae5ee46d4e3455ba09dfc091f626e59ecc29ad
 */
contract AaveV3EthENSListing_20230517_Payload is AaveV3PayloadEthereum {
  address public constant ENS = 0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72;
  address public constant ENS_PRICE_FEED = 0x5C00128d4d1c2F4f652C267d7bcdD7aC99C16E16;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: ENS,
      assetSymbol: 'ENS',
      priceFeed: ENS_PRICE_FEED,
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
      ltv: 39_00,
      liqThreshold: 49_00,
      liqBonus: 8_00,
      reserveFactor: 20_00,
      supplyCap: 1_000_000,
      borrowCap: 40_000,
      debtCeiling: 3_900_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
