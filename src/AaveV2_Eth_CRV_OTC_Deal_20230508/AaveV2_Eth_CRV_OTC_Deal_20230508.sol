// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @title aCRV OTC Deal
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: Direct-to-AIP proposal
 * - Discussion: https://governance.aave.com/t/arfc-acquire-crv-with-treasury-usdt/14251/57
 */
contract AaveV2_Eth_CRV_OTC_Deal_20230508 {
  address public constant MICH_ADDRESS = 0x7a16fF8270133F063aAb6C9977183D9e72835428;
  address public constant COLLECTOR = 0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c;
  address public constant AAVE_V2_LENDING_POOL = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;
  uint256 public constant aCRV_AMOUNT = 5_000_000e18; // 5M aCRV
  uint256 public constant USDT_AMOUNT = 2_000_000e6; // 2M USDT

  // TODO: for testing purpose rm after

  address public constant MOCK_ADDRESS = 0x329c54289Ff5D6B7b7daE13592C6B1EDA1543eD4;
  uint256 public constant MOCK_AMOUNT = 1e18;

  function execute() external {
    // pull aCRV from mich to collector will fail if no approval

    // IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).transferFrom(MICH_ADDRESS, COLLECTOR, aCRV_AMOUNT);

    // TODO: for testing purpose rm after

    IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).transferFrom(MOCK_ADDRESS, COLLECTOR, MOCK_AMOUNT);

    // transfer aUSDT from COLLECTOR to short_executor

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      address(this),
      USDT_AMOUNT
    );

    // withdraw aUSDT and convert it to USDT

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(AaveV2Ethereum.COLLECTOR)
    );

    // approve LendingPool to spend USDT_AMOUNT

    IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).approve(AAVE_V2_LENDING_POOL, USDT_AMOUNT);

    // repay mich debt with USDT
    
    // AaveV2Ethereum.POOL.repay(AaveV2EthereumAssets.USDT_UNDERLYING, USDT_AMOUNT, 2, MICH_ADDRESS);

    // TODO: for testing purpose rm after

    AaveV2Ethereum.POOL.repay(AaveV2EthereumAssets.USDT_UNDERLYING, USDT_AMOUNT, 2, MOCK_ADDRESS);
  }
}
