// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.17;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @title BAL Interest Rate Curve Upgrade
 * @author Llama
 * @notice Amend BAL interest rate parameters on the Aave Polygon v2liquidity pool.
 * Governance Forum Post: https://governance.aave.com/t/arfc-bal-interest-rate-upgrade/12423
 */
contract AaveV2PolRatesUpdates_20230328_Payload {
  address public constant INTEREST_RATE_STRATEGY = 0x54DA5057cdA764909f4c79bA9fbb2d4A214EeAe5;

  function execute() external {
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV2PolygonAssets.BAL_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
