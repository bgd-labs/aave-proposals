// SPDX-License-Identifier: MIT

/*
   _      ΞΞΞΞ      _
  /_;-.__ / _\  _.-;_\
     `-._`'`_/'`.-'
         `\   /`
          |  /
         /-.(
         \_._\
          \ \`;
           > |/
          / //
          |//
          \(\
           ``
     defijesus.eth
*/

pragma solidity 0.8.17;

import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title List FRAX on AaveV3Arbitrum
 * @author defijesus - TokenLogic
 * @dev This proposal lists FRAX on Aave V3 Arbitrum
 * Governance: https://governance.aave.com/t/arfc-add-frax-arbitrum-aave-v3/13222
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x03798dc3d6382f0d461590059d554a4405eefd5c95e3de917515702fdfc9ecfb
 */
contract AaveV3ArbFraxListing_20230619 is AaveV3PayloadArbitrum {
  address public constant PRICE_FEED = 0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8;
  address public constant FRAX_UNDERLYING = 0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F;

  function newListingsCustom() public pure override returns (IEngine.ListingWithCustomImpl[] memory) {
    IEngine.ListingWithCustomImpl[] memory listings = new IEngine.ListingWithCustomImpl[](1);

    listings[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
        asset: FRAX_UNDERLYING,
        assetSymbol: 'FRAX',
        priceFeed: PRICE_FEED,
        rateStrategyParams: Rates.RateStrategyParams({
          optimalUsageRatio: _bpsToRay(80_00),
          baseVariableBorrowRate: 0,
          variableRateSlope1: _bpsToRay(4_00),
          variableRateSlope2: _bpsToRay(75_00),
          stableRateSlope1: _bpsToRay(50),
          stableRateSlope2: _bpsToRay(75_00),
          baseStableRateOffset: _bpsToRay(1_00),
          stableRateExcessOffset: _bpsToRay(8_00),
          optimalStableToTotalDebtRatio: _bpsToRay(20_00)
        }),
        enabledToBorrow: EngineFlags.ENABLED,
        stableRateModeEnabled: EngineFlags.DISABLED,
        borrowableInIsolation: EngineFlags.DISABLED,
        withSiloedBorrowing: EngineFlags.DISABLED,
        flashloanable: EngineFlags.ENABLED,
        ltv: 70_00,
        liqThreshold: 75_00,
        liqBonus: 6_00,
        reserveFactor: 10_00,
        supplyCap: 7_000_000,
        borrowCap: 5_500_000,
        debtCeiling: 1_000_000,
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
