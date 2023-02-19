// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {Script} from 'forge-std/Script.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {WadRayMath} from 'aave-v3-core/contracts/protocol/libraries/math/WadRayMath.sol';
import {DefaultReserveInterestRateStrategy} from 'aave-v3-core/contracts/protocol/pool/DefaultReserveInterestRateStrategy.sol';

contract DeployStrategy is Script {
  struct RateStrategyConfig {
    uint256 optimalUsageRatio;
    uint256 baseVariableBorrowRate;
    uint256 variableRateSlope1;
    uint256 variableRateSlope2;
    uint256 stableRateSlope1;
    uint256 stableRateSlope2;
    uint256 baseStableRateOffset;
    uint256 stableRateExcessOffset;
    uint256 optimalStableToTotalDebtRatio;
  }

  constructor() WithChainIdValidation(42161) {}

  /** @dev Converts basis points to RAY units
   * e.g. 10_00 (10.00%) will return 100000000000000000000000000
   */
  function _bpsToRay(uint256 amount) internal pure returns (uint256) {
    return (amount * WadRayMath.RAY) / 10_000;
  }

  function _rateStrategy() internal pure returns (RateStrategyConfig memory) {
    return
      RateStrategyConfig({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(25),
        variableRateSlope1: _bpsToRay(4_50),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: 0,
        stableRateSlope2: 0,
        baseStableRateOffset: _bpsToRay(2_00),
        stableRateExcessOffset: _bpsToRay(5_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      });
  }

  function run() external {
    vm.startBroadcast();

    RateStrategyConfig memory strategy = _rateStrategy();

    new DefaultReserveInterestRateStrategy(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      strategy.optimalUsageRatio,
      strategy.baseVariableBorrowRate,
      strategy.variableRateSlope1,
      strategy.variableRateSlope2,
      strategy.stableRateSlope1,
      strategy.stableRateSlope2,
      strategy.baseStableRateOffset,
      strategy.stableRateExcessOffset,
      strategy.optimalStableToTotalDebtRatio
    );

    vm.stopBroadcast();
  }
}
