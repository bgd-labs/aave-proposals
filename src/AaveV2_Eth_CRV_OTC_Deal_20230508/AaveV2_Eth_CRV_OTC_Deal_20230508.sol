// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title aCRV OTC Deal
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: Direct-to-AIP proposal
 * - Discussion: https://governance.aave.com/t/arfc-acquire-crv-with-treasury-usdt/14251/57
 */
contract AaveV2_Eth_CRV_OTC_Deal_20230508 {
  using SafeERC20 for IERC20;

  address public constant MICH_ADDRESS = 0x7a16fF8270133F063aAb6C9977183D9e72835428;
  uint256 public constant aCRV_AMOUNT = 5_000_000e18; // 5M aCRV
  uint256 public constant USDT_AMOUNT = 2_000_000e6; // 2M USDT

  function execute() external {
    // pull aCRV from mich to collector will fail if no approval

    IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).safeTransferFrom(
      MICH_ADDRESS,
      address(AaveV2Ethereum.COLLECTOR),
      aCRV_AMOUNT
    );

    // Transfer aUSDT from COLLECTOR to short_executor

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      address(this),
      USDT_AMOUNT
    );

    // withdraw aUSDT and convert it to USDT

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).forceApprove(address(AaveV2Ethereum.POOL), USDT_AMOUNT);

    // repay mich debt with USDT

    AaveV2Ethereum.POOL.repay(AaveV2EthereumAssets.USDT_UNDERLYING, USDT_AMOUNT, 2, MICH_ADDRESS);
  }
}
