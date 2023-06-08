// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title List LUSD on Aave V3 Arbitrum
 * @author Llama
 * @dev This proposal lists LUSD on Aave V3 Arbitrum
 * Governance: https://governance.aave.com/t/arfc-add-lusd-to-aave-v3-on-arbitrum/12858
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xcd09c811c9f5f58693656846f119dfd7561b10de6b5d91f860634b228cb7ee04
 */
contract AaveV3ArbListings_20230523_Payload is AaveV3PayloadArbitrum {
  address public constant LUSD = 0x93b346b6BC2548dA6A1E7d98E9a421B42541425b;
  address public constant LUSD_PRICE_FEED = 0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF;

  function newListingsCustom()
    public
    pure
    override
    returns (IEngine.ListingWithCustomImpl[] memory)
  {
    IEngine.ListingWithCustomImpl[] memory listings = new IEngine.ListingWithCustomImpl[](1);

    listings[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
        asset: LUSD,
        assetSymbol: 'LUSD',
        priceFeed: LUSD_PRICE_FEED,
        rateStrategyParams: Rates.RateStrategyParams({
          optimalUsageRatio: _bpsToRay(80_00),
          baseVariableBorrowRate: 0,
          variableRateSlope1: _bpsToRay(4_00),
          variableRateSlope2: _bpsToRay(87_00),
          stableRateSlope1: _bpsToRay(4_00),
          stableRateSlope2: _bpsToRay(87_00),
          baseStableRateOffset: _bpsToRay(1_00),
          stableRateExcessOffset: _bpsToRay(8_00),
          optimalStableToTotalDebtRatio: _bpsToRay(20_00)
        }),
        enabledToBorrow: EngineFlags.ENABLED,
        stableRateModeEnabled: EngineFlags.DISABLED,
        borrowableInIsolation: EngineFlags.DISABLED,
        withSiloedBorrowing: EngineFlags.DISABLED,
        flashloanable: EngineFlags.ENABLED,
        ltv: 0,
        liqThreshold: 0,
        liqBonus: 0,
        reserveFactor: 10_00,
        supplyCap: 900_000,
        borrowCap: 900_000,
        debtCeiling: 0,
        liqProtocolFee: 0,
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
