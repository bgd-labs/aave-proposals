// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthFEIRiskParams_20230703} from './AaveV2EthFEIRiskParams_20230703.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig, InterestStrategyValues} from 'aave-helpers/ProtocolV2TestBase.sol';
import {WadRayMath} from 'aave-v3-core/contracts/protocol/libraries/math/WadRayMath.sol';
import {IDefaultInterestRateStrategy} from 'aave-address-book/AaveV2.sol';

contract AaveV2EthFEIRiskParams_20230703_Test is ProtocolV2TestBase {
  uint256 public constant FEI_LTV = 0; // 0%
  uint256 public constant FEI_LIQUIDATION_THRESHOLD = 1_00; // 1%
  uint256 public constant FEI_LIQUIDATION_BONUS = 11000; // 10%
  uint256 public constant FEI_UOPTIMAL = 1_00; // 1%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17778245);
  }

  function testPayload() public {
    AaveV2EthFEIRiskParams_20230703 proposalPayload = new AaveV2EthFEIRiskParams_20230703();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2EthFEIRiskParams_20230703Change',
      AaveV2Ethereum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2EthFEIRiskParams_20230703Change',
      AaveV2Ethereum.POOL
    );

    // 4. verify payload:
    ReserveConfig memory FEI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.FEI_UNDERLYING
    );

    ReserveConfig memory FEI_UNDERLYING_CONFIG_AFTER = _findReserveConfig(
      allConfigsAfter,
      AaveV2EthereumAssets.FEI_UNDERLYING
    );

    assert(
      FEI_UNDERLYING_CONFIG.interestRateStrategy != FEI_UNDERLYING_CONFIG_AFTER.interestRateStrategy
    );

    FEI_UNDERLYING_CONFIG.ltv = FEI_LTV;
    FEI_UNDERLYING_CONFIG.liquidationThreshold = FEI_LIQUIDATION_THRESHOLD;
    FEI_UNDERLYING_CONFIG.liquidationBonus = FEI_LIQUIDATION_BONUS;
    FEI_UNDERLYING_CONFIG.interestRateStrategy = FEI_UNDERLYING_CONFIG_AFTER.interestRateStrategy;

    _validateReserveConfig(FEI_UNDERLYING_CONFIG, allConfigsAfter);

    IDefaultInterestRateStrategy strategyBefore = IDefaultInterestRateStrategy(
      FEI_UNDERLYING_CONFIG.interestRateStrategy
    );

    _validateInterestRateStrategy(
      FEI_UNDERLYING_CONFIG_AFTER.interestRateStrategy,
      FEI_UNDERLYING_CONFIG_AFTER.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV2Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: _bpsToRay(FEI_UOPTIMAL),
        baseVariableBorrowRate: strategyBefore.baseVariableBorrowRate(),
        stableRateSlope1: strategyBefore.stableRateSlope1(),
        stableRateSlope2: strategyBefore.stableRateSlope2(),
        variableRateSlope1: strategyBefore.variableRateSlope1(),
        variableRateSlope2: strategyBefore.variableRateSlope2()
      })
    );

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV2EthereumAssets.FEI_UNDERLYING
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV2EthFEIRiskParams_20230703Change',
      'postAaveV2EthFEIRiskParams_20230703Change'
    );

    // 6. e2e Test
    e2eTest(AaveV2Ethereum.POOL);
  }

  /** @dev Converts basis points to RAY units
   * e.g. 10_00 (10.00%) will return 100000000000000000000000000
   */
  function _bpsToRay(uint256 amount) internal pure returns (uint256) {
    return (amount * WadRayMath.RAY) / 10_000;
  }
}
