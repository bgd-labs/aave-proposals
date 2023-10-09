// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Expansion of Orbit
 * @author Marc Zeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xecd62eb5dca71e47e7e1d0e88f8e6127857c051bea190fe0eb665636b33caa62
 * - Discussion: https://governance.aave.com/t/arfc-expansion-of-orbit-a-dao-funded-delegate-platform-initiative/14785
 */
contract AaveV3_Ethereum_ExpansionOfOrbit_20230925 {
  address public constant STABLE_LABS = 0x9c489E4efba90A67299C1097a8628e233C33BB7B;
  address public constant KEYROCK = 0x1855f41B8A86e701E33199DE7C25d3e3830698ba;
  address public constant LBS_BLOCKCHAIN = 0xb5d08b1fDb70aE0Da7e07D201D4D8ffcA9d24dc1;
  address public constant HKUST = 0xE4594A66d9507fFc0d4335CC240BD61C1173E666;
  address public constant MICHIGAN = 0x13BDaE8c5F0fC40231F0E6A4ad70196F59138548;
  address public constant GHO = AaveV3EthereumAssets.GHO_UNDERLYING;
  uint256 public constant STREAM_AMOUNT = 15000e18;
  uint256 public constant STREAM_DURATION = 90 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.createStream(
      STABLE_LABS,
      ACTUAL_STREAM_AMOUNT_GHO,
      GHO,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );

    AaveV2Ethereum.COLLECTOR.createStream(
      KEYROCK,
      ACTUAL_STREAM_AMOUNT_GHO,
      GHO,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );

    AaveV2Ethereum.COLLECTOR.createStream(
      LBS_BLOCKCHAIN,
      ACTUAL_STREAM_AMOUNT_GHO,
      GHO,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );

    AaveV2Ethereum.COLLECTOR.createStream(
      HKUST,
      ACTUAL_STREAM_AMOUNT_GHO,
      GHO,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );

    AaveV2Ethereum.COLLECTOR.createStream(
      MICHIGAN,
      ACTUAL_STREAM_AMOUNT_GHO,
      GHO,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
