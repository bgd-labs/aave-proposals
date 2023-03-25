// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {Script} from 'forge-std/Script.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {WadRayMath} from 'aave-v3-core/contracts/protocol/libraries/math/WadRayMath.sol';
import {DefaultReserveInterestRateStrategy} from 'aave-v3-core/contracts/protocol/pool/DefaultReserveInterestRateStrategy.sol';
import {AaveV3OptLUSDPayload} from '../src/contracts/optimism/AaveV3OptLusdPayload.sol';

contract DeployOptLUSDStrategy is Script {
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

  function _rateStrategyOptLUSD() internal pure returns (RateStrategyConfig memory) {
    return
      RateStrategyConfig({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(4_00),
        variableRateSlope2: _bpsToRay(87_00),
        stableRateSlope1: _bpsToRay(4_00),
        stableRateSlope2: _bpsToRay(87_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      });
  }

  function run() external {
    vm.startBroadcast();

    RateStrategyConfig memory strategyOptLUSD = _rateStrategyOptLUSD();

    new DefaultReserveInterestRateStrategy(
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
      strategyOptLUSD.optimalUsageRatio,
      strategyOptLUSD.baseVariableBorrowRate,
      strategyOptLUSD.variableRateSlope1,
      strategyOptLUSD.variableRateSlope2,
      strategyOptLUSD.stableRateSlope1,
      strategyOptLUSD.stableRateSlope2,
      strategyOptLUSD.baseStableRateOffset,
      strategyOptLUSD.stableRateExcessOffset,
      strategyOptLUSD.optimalStableToTotalDebtRatio
    );

    vm.stopBroadcast();
  }
}