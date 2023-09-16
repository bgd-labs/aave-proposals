// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @title TUSD offboarding plan
 * @author Marc Zeller (@marczeller - Aave Chan Initiative), Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xfd0cdbf58992759f47e6f5a6c07cbeb2b1a02af1c9ebf7d3099b80c33f53c138
 * - Discussion: https://governance.aave.com/t/arfc-tusd-offboarding-plan/14008
 */
contract AaveV2_Eth_TUSDOffboardingPlan_20233107 {
  address public constant INTEREST_RATE_STRATEGY = 0x67a81df2b7FAf4a324D94De9Cc778704F4500478;
  uint256 public constant TUSD_LTV = 0; /// 80 -> 0
  uint256 public constant TUSD_LIQUIDATION_THRESHOLD = 75_00; // 77.5 -> 75
  uint256 public constant TUSD_LIQUIDATION_BONUS = 11000; // 5 -> 10
  uint256 public constant RESERVE_FACTOR = 95_00; // 10 -> 95

  function execute() external {
    // set LTV to Zero, decrease liquidation threshold and increase liquiditation bonus

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      TUSD_LTV,
      TUSD_LIQUIDATION_THRESHOLD,
      TUSD_LIQUIDATION_BONUS
    );

    // set reserve factor to 95%

    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      RESERVE_FACTOR
    );

    // disable borrowing on TUSD

    AaveV2Ethereum.POOL_CONFIGURATOR.disableBorrowingOnReserve(
      AaveV2EthereumAssets.TUSD_UNDERLYING
    );

    // disable stable rate borrowing on TUSD

    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.TUSD_UNDERLYING);

    // unlike BUSD AIP, we withdraw TUSD from pool first then change the rate strategy following BGD labs recommendations

    uint256 aTUSDBalance = IERC20(AaveV2EthereumAssets.TUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 availableTUSD = IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(
      AaveV2EthereumAssets.TUSD_A_TOKEN
    );
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.TUSD_A_TOKEN,
      address(this),
      aTUSDBalance > availableTUSD ? availableTUSD : aTUSDBalance
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      type(uint256).max,
      address(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
