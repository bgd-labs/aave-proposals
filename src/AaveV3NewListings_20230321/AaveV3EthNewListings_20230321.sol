// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title List UNI, MKR, SNX and BAL on AaveV3Ethereum
 * @author Llama
 * @dev This proposal lists UNI, MKR, SNX and BAL on Aave V3 Ethereum
 * Governance UNI: https://governance.aave.com/t/arfc-add-uni-to-ethereum-v3/11953
 * Governance MKR: https://governance.aave.com/t/arfc-add-mkr-to-ethereum-v3/11954
 * Governance SNX: https://governance.aave.com/t/arfc-add-snx-to-ethereum-v3/11956
 * Governance BAL: https://governance.aave.com/t/arfc-add-bal-ethereum-v3/11523
 * Snapshot UNI: https://snapshot.org/#/aave.eth/proposal/0x51d67ef69e901b34f1d111f2cd5d582c59cffa8d70b7939023febd20f7613b88
 * Snapshot BAL: https://snapshot.org/#/aave.eth/proposal/0xe394799e4d006c15e0cb13155701de495888b7e7dad8f917a6b5dd1c8106cea5
 * Snapshot MKR: https://snapshot.org/#/aave.eth/proposal/0xf4aec3fbab5096752be96f0e5b522f37318c1902cf8b897b049b7a94d478de73
 * Snapshot SNX: https://snapshot.org/#/aave.eth/proposal/0x5f232a89e10d67df3aad2907e8dce3bec9708596929b3254055cf37499969b89
 */
contract AaveV3EthNewListings_20230321 is AaveV3PayloadEthereum {
  address public constant UNI_PRICE_FEED = 0x553303d460EE0afB37EdFf9bE42922D8FF63220e;
  address public constant MKR_PRICE_FEED = 0xec1D1B3b0443256cc3860e24a46F108e699484Aa;
  address public constant SNX_PRICE_FEED = 0xDC3EA94CD0AC27d9A86C180091e7f78C683d3699;
  address public constant BAL_PRICE_FEED = 0xdF2917806E30300537aEB49A7663062F4d1F2b5F;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](3);

    listings[0] = IEngine.Listing({
      asset: AaveV2EthereumAssets.MKR_UNDERLYING,
      assetSymbol: 'MKR',
      priceFeed: MKR_PRICE_FEED,
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
      ltv: 65_00,
      liqThreshold: 70_00,
      liqBonus: 8_50,
      reserveFactor: 20_00,
      supplyCap: 6_000,
      borrowCap: 1_500,
      debtCeiling: 2_500_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    listings[1] = IEngine.Listing({
      asset: AaveV2EthereumAssets.SNX_UNDERLYING,
      assetSymbol: 'SNX',
      priceFeed: SNX_PRICE_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(3_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(100_00),
        stableRateSlope1: _bpsToRay(15_00),
        stableRateSlope2: _bpsToRay(100_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: _bpsToRay(5_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 49_00,
      liqThreshold: 65_00,
      liqBonus: 8_50,
      reserveFactor: 35_00,
      supplyCap: 2_000_000,
      borrowCap: 1_100_000,
      debtCeiling: 2_500_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    listings[2] = IEngine.Listing({
      asset: AaveV2EthereumAssets.BAL_UNDERLYING,
      assetSymbol: 'BAL',
      priceFeed: BAL_PRICE_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(3_00),
        variableRateSlope1: _bpsToRay(14_00),
        variableRateSlope2: _bpsToRay(150_00),
        stableRateSlope1: _bpsToRay(20_00),
        stableRateSlope2: _bpsToRay(150_00),
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
      liqThreshold: 62_00,
      liqBonus: 8_30,
      reserveFactor: 20_00,
      supplyCap: 700_000,
      borrowCap: 185_000,
      debtCeiling: 2_900_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }

  function newListingsCustom()
    public
    pure
    override
    returns (IEngine.ListingWithCustomImpl[] memory)
  {
    IEngine.ListingWithCustomImpl[] memory listingsCustom = new IEngine.ListingWithCustomImpl[](1);

    listingsCustom[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
        asset: AaveV2EthereumAssets.UNI_UNDERLYING,
        assetSymbol: 'UNI',
        priceFeed: UNI_PRICE_FEED,
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
        ltv: 65_00,
        liqThreshold: 77_00,
        liqBonus: 10_00,
        reserveFactor: 20_00,
        supplyCap: 2_000_000,
        borrowCap: 500_000,
        debtCeiling: 17_000_000,
        liqProtocolFee: 10_00,
        eModeCategory: 0
      }),
      IEngine.TokenImplementations({
        aToken: AaveV3Ethereum.DELEGATION_AWARE_A_TOKEN_IMPL_REV_1,
        vToken: AaveV3Ethereum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1,
        sToken: AaveV3Ethereum.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1
      })
    );

    return listingsCustom;
  }
}
