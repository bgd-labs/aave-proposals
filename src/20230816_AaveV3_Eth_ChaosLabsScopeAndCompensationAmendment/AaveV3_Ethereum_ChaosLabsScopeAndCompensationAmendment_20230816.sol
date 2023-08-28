// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Chaos Labs Scope and Compensation Amendment
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/\#/aave.eth/proposal/0xfba8276d2608409e7cc902a1d53d5ccacced03b4e8bbb42b331ba6539bd23f4e
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-scope-and-compensation-amendment/14407
 */
contract AaveV3_Ethereum_ChaosLabsScopeAndCompensationAmendment_20230816 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;

  address public constant CHAOS_LABS_TREASURY = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;
  uint256 public constant STREAM_AMOUNT = 400_000e6;
  uint256 public constant STREAM_DURATION = 77 days; // Aug 22th 2023 - Nov 7th 2023
  uint256 public constant ACTUAL_STREAM_AMOUNT_A_USDT =
    (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      address(this),
      ACTUAL_STREAM_AMOUNT_A_USDT
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(this)
    );
    IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      ACTUAL_STREAM_AMOUNT_A_USDT
    );
    AaveV3Ethereum.POOL.supply(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(this)),
      address(AaveV3Ethereum.COLLECTOR),
      0
    );
    AaveV3Ethereum.COLLECTOR.createStream(
      CHAOS_LABS_TREASURY,
      ACTUAL_STREAM_AMOUNT_A_USDT,
      AaveV3EthereumAssets.USDT_A_TOKEN,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
