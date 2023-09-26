// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Aave treasury RWA Allocation Part I
 * @author Marc Zeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x71db494e4b49e7533c5ccaa566686b2d045b0761cb3296a2d77af4b500566eb0
 * - Discussion: https://governance.aave.com/t/arfc-aave-treasury-rwa-allocation/14790
 */
contract AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925 {
  using SafeERC20 for IERC20;

  address public constant CENTRIFUGE = 0x9c489E4efba90A67299C1097a8628e233C33BB7B; // Placeholder until address is confirmed, DO NOT MERGE
  uint256 public constant STREAM_AMOUNT = 500e18;
  uint256 public constant STREAM_DURATION = 720 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_AAVE =
    (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;
  uint256 public constant USDC_AMOUNT = 50_000e6;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      address(this),
      USDC_AMOUNT
    );

    // I needed to approve the transfer of USDC to CENTRIFUGE why?

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).approve(address(this), USDC_AMOUNT);

    // withdraw aUSDC and convert it to USDC

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    // transfer USDC to CENTRIFUGE

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).safeTransferFrom(
      address(this),
      CENTRIFUGE,
      USDC_AMOUNT
    );

    // send back USDC dust to COLLECTOR

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).approve(address(this), USDC_AMOUNT);

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).safeTransferFrom(
      address(this),
      address(AaveV2Ethereum.COLLECTOR),
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(this))
    );

    // create AAVE stream for CENTRIFUGE
    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      AaveMisc.ECOSYSTEM_RESERVE,
      CENTRIFUGE,
      ACTUAL_STREAM_AMOUNT_AAVE,
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
