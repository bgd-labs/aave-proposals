// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title List rETH on Aave V3 Arbitrum
 * @author Llama
 * @dev This proposal lists rETH on Aave V3 Arbitrum
 * Governance rETH: https://governance.aave.com/t/arfc-add-reth-to-aave-v3-arbitrum-liquidity-pool/12810
 * Snapshot rETH: https://snapshot.org/#/aave.eth/proposal/0xa7bc42ca1f658655e9998d22d616133da734bad0e6caae9c7d016ad97abf1451
 * Governance LUSD: https://governance.aave.com/t/arfc-add-lusd-to-aave-v3-on-arbitrum/12858
 * Snapshot LUSD: https://snapshot.org/#/aave.eth/proposal/0xcd09c811c9f5f58693656846f119dfd7561b10de6b5d91f860634b228cb7ee04
 */
contract AaveV3ArbListings_20230523_Payload is AaveV3PayloadArbitrum {
  address public constant RETH = 0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8;
  address public constant RETH_PRICE_FEED = address(0); // TODO: Create Syncrhonicity

  address public constant LUSD = 0x93b346b6BC2548dA6A1E7d98E9a421B42541425b;
  address public constant LUSD_PRICE_FEED = 0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](2);

    listings[0] = IEngine.Listing({
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
      flashloanable: EngineFlags.DISABLED,
      ltv: 67_00,
      liqThreshold: 74_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 325,
      borrowCap: 85,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    listings[1] = IEngine.Listing({
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
      flashloanable: EngineFlags.DISABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 900_000,
      borrowCap: 900_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      eModeCategory: 0
    });

    return listings;
  }
}