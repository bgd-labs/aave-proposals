// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {ILendingPoolConfigurator} from 'aave-address-book/AaveV2.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

struct RateUpdate {
  address asset;
  address interestRateStrategyAddress;
}

abstract contract AaveV2RateUpdatePayloadBase is IProposalGenericExecutor {
  function _poolConfigurator() internal virtual returns (ILendingPoolConfigurator);

  function _rateUpdates() internal virtual returns (RateUpdate[] memory);

  function execute() external {
    RateUpdate[] memory rateUpdates = _rateUpdates();
    ILendingPoolConfigurator poolConfigurator = _poolConfigurator();

    for (uint256 i = 0; i < rateUpdates.length; i++) {
      poolConfigurator.setReserveInterestRateStrategyAddress(
        rateUpdates[i].asset,
        rateUpdates[i].interestRateStrategyAddress
      );
    }
  }
}

contract AaveV2PolygonIR_20230519 is AaveV2RateUpdatePayloadBase {
  function _poolConfigurator() internal pure override returns (ILendingPoolConfigurator) {
    return AaveV2Polygon.POOL_CONFIGURATOR;
  }

  function _rateUpdates() internal pure override returns (RateUpdate[] memory) {
    RateUpdate[] memory rateUpdates = new RateUpdate[](4);

    rateUpdates[0] = RateUpdate({
      asset: AaveV2PolygonAssets.USDT_UNDERLYING,
      interestRateStrategyAddress: 0xD2C92b5A793e196aB11dBefBe3Af6BddeD6c3DD5
    });
    rateUpdates[1] = RateUpdate({
      asset: AaveV2PolygonAssets.WBTC_UNDERLYING,
      interestRateStrategyAddress: 0x1d41b83e5bdbB21c4dD924507cBde66CD865d029
    });
    rateUpdates[2] = RateUpdate({
      asset: AaveV2PolygonAssets.WETH_UNDERLYING,
      interestRateStrategyAddress: 0xD792a3779D3C80bAEe8CF3304D6aEAc74bC432BE
    });
    rateUpdates[3] = RateUpdate({
      asset: AaveV2PolygonAssets.WMATIC_UNDERLYING,
      interestRateStrategyAddress: 0x893411580e590D62dDBca8a703d61Cc4A8c7b2b9
    });

    return rateUpdates;
  }
}
