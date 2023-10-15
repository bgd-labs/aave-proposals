// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title TokenLogic Hohmann Transfer
 * @author Marc Zeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x89c3286743dc99b961d40d948c9507fe1005bc6fedf7e34ffb3d1265e0bc4bff
 * - Discussion: https://governance.aave.com/t/arfc-tokenlogic-hohmann-transfer/15051
 */
contract AaveV3_Ethereum_TokenLogicHohmannTransfer_20231015 {
  address public constant TOKEN_LOGIC = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;
  address public constant GHO = AaveV3EthereumAssets.GHO_UNDERLYING;
  uint256 public constant STREAM_AMOUNT = 15000e18;
  uint256 public constant STREAM_DURATION = 90 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.createStream(
      TOKEN_LOGIC,
      ACTUAL_STREAM_AMOUNT_GHO,
      GHO,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
