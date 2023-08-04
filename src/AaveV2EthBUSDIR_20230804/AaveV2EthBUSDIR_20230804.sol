// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title [ARFC] BUSD Offboarding Plan part III
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x389c0cd79720fd9853ca6714f4597484dd25cc3a5e34955bf6144f0ba1888a3a
 * - Discussion: https://governance.aave.com/t/arfc-busd-offboarding-plan-part-iii/14136
 */
contract AaveV2EthBUSDIR_20230804 is IProposalGenericExecutor {
  address public constant INTEREST_RATE_STRATEGY = 0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69;

  function execute() external {
    uint256 aBUSDBalance = IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 availableBUSD = IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(
      AaveV2EthereumAssets.BUSD_A_TOKEN
    );
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.BUSD_A_TOKEN,
      address(this),
      aBUSDBalance > availableBUSD ? availableBUSD : aBUSDBalance
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      type(uint256).max,
      address(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
