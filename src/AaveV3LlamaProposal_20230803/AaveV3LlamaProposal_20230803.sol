// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Reduce Llama Stream
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xceae27bbaf42658a1b46baec664c66c09f9cba4f9452ed2d2bed6f6ce5c66e35
 * - Discussion: https://governance.aave.com/t/arfc-cancel-llama-service-provider-stream/14137
 */
contract AaveV3LlamaProposal_20230803 is IProposalGenericExecutor {
  address public constant LLAMA_RECIPIENT = 0xb428C6812E53F843185986472bb7c1E25632e0f7;
  uint256 public constant ER_AAVE_STREAM = 100001;
  uint256 public constant COLLECTOR_aUSDC_STREAM = 100003;

  uint256 public constant AAVE_STREAM_AMOUNT = 283230000000000000000;
  uint256 public constant AUSDC_STREAM_AMOUNT = 54659610000;
  uint256 public constant STREAM_DURATION = 57 days;
  uint256 public constant ACTUAL_AMOUNT_AUSDC =
    (AUSDC_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;
  uint256 public constant ACTUAL_AMOUNT_AAVE =
    (AAVE_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    // cancel old streams
    AaveV2Ethereum.COLLECTOR.cancelStream(COLLECTOR_aUSDC_STREAM);
    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.cancelStream(
      AaveMisc.ECOSYSTEM_RESERVE,
      ER_AAVE_STREAM
    );

    // create new streams
    AaveV2Ethereum.COLLECTOR.createStream(
      LLAMA_RECIPIENT,
      ACTUAL_AMOUNT_AUSDC,
      AaveV2EthereumAssets.USDC_A_TOKEN,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );

    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      AaveMisc.ECOSYSTEM_RESERVE,
      LLAMA_RECIPIENT,
      ACTUAL_AMOUNT_AAVE,
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
