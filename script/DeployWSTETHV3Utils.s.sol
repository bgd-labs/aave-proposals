// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from 'forge-std/Script.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {WadRayMath} from 'aave-v3-core/contracts/protocol/libraries/math/WadRayMath.sol';
import {DefaultReserveInterestRateStrategy} from 'aave-v3-core/contracts/protocol/pool/DefaultReserveInterestRateStrategy.sol';
import {AaveV3OPWSTETHPayload} from '../src/contracts/optimism/AaveV3OPWSTETHPayload.sol';

contract DeployWSTETHStrategy is Script {
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

  /** @dev Converts basis points to RAY units
   * e.g. 10_00 (10.00%) will return 100000000000000000000000000
   */
  function _bpsToRay(uint256 amount) internal pure returns (uint256) {
    return (amount * WadRayMath.RAY) / 10_000;
  }

  function _rateStrategyWSTETH() internal pure returns (RateStrategyConfig memory) {
    return
      RateStrategyConfig({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(25),
        variableRateSlope1: _bpsToRay(4_50),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: _bpsToRay(4_50),
        stableRateSlope2: _bpsToRay(80_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      });
  }

  function run() external {
    vm.startBroadcast();

    RateStrategyConfig memory strategyWSTETH = _rateStrategyWSTETH();

    new DefaultReserveInterestRateStrategy(
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
      strategyWSTETH.optimalUsageRatio,
      strategyWSTETH.baseVariableBorrowRate,
      strategyWSTETH.variableRateSlope1,
      strategyWSTETH.variableRateSlope2,
      strategyWSTETH.stableRateSlope1,
      strategyWSTETH.stableRateSlope2,
      strategyWSTETH.baseStableRateOffset,
      strategyWSTETH.stableRateExcessOffset,
      strategyWSTETH.optimalStableToTotalDebtRatio
    );

    vm.stopBroadcast();
  }
}
