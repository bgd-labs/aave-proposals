// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Chaos Labs Scope and Compensation Amendment
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/\#/aave.eth/proposal/0xfba8276d2608409e7cc902a1d53d5ccacced03b4e8bbb42b331ba6539bd23f4e
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-scope-and-compensation-amendment/14407
 */
contract AaveV3_Ethereum_ChaosLabsScopeAndCompensationAmendment_20230816 is
  IProposalGenericExecutor
{
  address public constant CHAOS_LABS_TREASURY = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;
  uint256 public constant STREAM_AMOUNT = 400_000e6;
  uint256 public constant STREAM_DURATION = 80 days; // Aug 19th 2023 - Nov 7th 2023
  uint256 public constant ACTUAL_STREAM_AMOUNT_A_USDT =
    (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.createStream(
      CHAOS_LABS_TREASURY,
      ACTUAL_STREAM_AMOUNT_A_USDT,
      AaveV2EthereumAssets.USDT_A_TOKEN,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
