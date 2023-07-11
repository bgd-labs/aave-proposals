// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';


/**
 * @title Add RPL to Aave V3 pool
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Eth_AaveV3ListRPL_20230711_20231107 is AaveV3PayloadEthereum {
address public constant RPL_USD_FEED = 0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d;
address public constant RPL = 0xD33526068D116cE69F19A9ee46F0bd304F21A51f;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: RPL,
      assetSymbol: 'RPL',
      priceFeed: RPL_USD_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(8_50),
        variableRateSlope2: _bpsToRay(87_00),
        stableRateSlope1: _bpsToRay(8_50),
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
      reserveFactor: 20_00,
      supplyCap: 105_000,
      borrowCap: 105_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      eModeCategory: 0
    });

    return listings;
  }
}