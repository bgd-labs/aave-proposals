// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title List wstETH on AaveV3Polygon
 * @author Llama
 * @dev This proposal lists wstETH on Aave V3 Polygon
 * Governance: https://governance.aave.com/t/arc-add-support-for-wsteth-on-polygon-v3/12266
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9d7296b06a66d6d6b4c9e85051477a4d62d066e3f56c248bcc85cbea00f7c7a4
 */
contract AaveV3Listings_20230413_Payload is AaveV3PayloadPolygon {
  address public constant wstETH = 0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD;
  address public constant wstETH_PRICE_FEED = 0xA2508729b1282Cc70dd33Ed311d4A9A37383035b;

  string public constant EMODE_LABEL_ETH_CORRELATED = 'ETH correlated';
  uint16 public constant EMODE_LTV_ETH_CORRELATED = 90_00;
  uint16 public constant EMODE_LT_ETH_CORRELATED = 93_00;
  uint16 public constant EMODE_LBONUS_ETH_CORRELATED = 10_100;
  uint8 public constant EMODE_CATEGORY_ID_ETH_CORRELATED = 3;

  function _preExecute() internal override {
    AaveV3Polygon.POOL_CONFIGURATOR.setEModeCategory(
      EMODE_CATEGORY_ID_ETH_CORRELATED,
      EMODE_LTV_ETH_CORRELATED,
      EMODE_LT_ETH_CORRELATED,
      EMODE_LBONUS_ETH_CORRELATED,
      address(0),
      EMODE_LABEL_ETH_CORRELATED
    );

    AaveV3Polygon.POOL_CONFIGURATOR.setAssetEModeCategory(
      AaveV3PolygonAssets.WETH_UNDERLYING,
      EMODE_CATEGORY_ID_ETH_CORRELATED
    );
  }

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: wstETH_PRICE_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(25),
        variableRateSlope1: _bpsToRay(4_50),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: _bpsToRay(4_50),
        stableRateSlope2: _bpsToRay(80_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 70_00,
      liqThreshold: 79_00,
      liqBonus: 7_20,
      reserveFactor: 15_00,
      supplyCap: 1_800,
      borrowCap: 285,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: EMODE_CATEGORY_ID_ETH_CORRELATED
    });

    return listings;
  }
}
