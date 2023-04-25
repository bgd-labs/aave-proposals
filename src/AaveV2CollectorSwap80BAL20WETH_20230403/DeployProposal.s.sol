// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {SwapFor80BAL20WETHPayload} from './AaveV2CollectorSwap80BAL20WETH_20230403_Payload.sol';

contract DeployPayload is EthereumScript {
  function run() external broadcast {
    new SwapFor80BAL20WETHPayload();
  }
}
