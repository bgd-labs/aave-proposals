// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title AURA OTC Deal
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xeb88691a23f3b1f9dfb4d2fb575fa19e75050a67b80b23eff91c0d430a177bd1
 * - Discussion: https://governance.aave.com/t/arfc-acquire-crv-with-treasury-usdt/14251/57
 */
contract AaveV2_Eth_AURA_OTC_Deal_20230508 {
  using SafeERC20 for IERC20;

  address public constant OLYMPUS_ADDRESS = 0x245cc372C84B3645Bf0Ffe6538620B04a217988B;
  address public constant AURA_TOKEN = 0xC0c293ce456fF0ED870ADd98a0828Dd4d2903DBF;
  uint256 public constant AURA_AMOUNT = 443_674e18;
  uint256 public constant DAI_AMOUNT = 420_159e18;

  function execute() external {
    // pull AURA from Olympus wallet to collector will fail if no approval

    IERC20(AURA_TOKEN).safeTransferFrom(
      OLYMPUS_ADDRESS,
      address(AaveV2Ethereum.COLLECTOR),
      AURA_AMOUNT
    );

    // Transfer aDAI from COLLECTOR to short_executor

    AaveV2Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.DAI_A_TOKEN, address(this), DAI_AMOUNT);

    // withdraw aDAI and convert it to DAI

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    // transfer DAI to Olympus

    IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).safeTransferFrom(
      address(this),
      OLYMPUS_ADDRESS,
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(this))
    );
  }
}
