// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {Script} from 'forge-std/Script.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {WadRayMath} from 'aave-v3-core/contracts/protocol/libraries/math/WadRayMath.sol';
import {DefaultReserveInterestRateStrategy} from 'aave-v3-core/contracts/protocol/pool/DefaultReserveInterestRateStrategy.sol';
import {AaveV3EthUSDTPayload} from '../src/contracts/mainnet/AaveV3EthUSDTPayload.sol';

contract DeployMainnetPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}

  function run() external {
    vm.startBroadcast();
    new AaveV3EthUSDTPayload();
    vm.stopBroadcast();
  }
}

contract DeployUSDTStrategy is Script {
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

  function _rateStrategyUSDT() internal pure returns (RateStrategyConfig memory) {
    return
      RateStrategyConfig({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(4_00),
        variableRateSlope2: _bpsToRay(72_00),
        stableRateSlope1: _bpsToRay(4_00),
        stableRateSlope2: _bpsToRay(72_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      });
  }

  function run() external {
    vm.startBroadcast();

    RateStrategyConfig memory strategyUSDT = _rateStrategyUSDT();

    new DefaultReserveInterestRateStrategy(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      strategyUSDT.optimalUsageRatio,
      strategyUSDT.baseVariableBorrowRate,
      strategyUSDT.variableRateSlope1,
      strategyUSDT.variableRateSlope2,
      strategyUSDT.stableRateSlope1,
      strategyUSDT.stableRateSlope2,
      strategyUSDT.baseStableRateOffset,
      strategyUSDT.stableRateExcessOffset,
      strategyUSDT.optimalStableToTotalDebtRatio
    );

    vm.stopBroadcast();
  }
}
