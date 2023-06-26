// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {SwapFor80BAL20WETHPayload} from './AaveV2CollectorSwap80BAL20WETH_20230403_Payload.sol';

contract DeployPayload is EthereumScript {
  function run() external broadcast {
    new SwapFor80BAL20WETHPayload();
  }
}

contract SinglePayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV2CollectorSwap80BAL20WETH_20230403/SWAP-ASSETS-FOR-BPT.md'));
  }
}
