// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3LlamaProposal_20230803} from 'src/AaveV3LlamaProposal_20230803/AaveV3LlamaProposal_20230803.sol';

contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3LlamaProposal_20230803();
  }
}

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x5AE34639F76ddF430850589c9e9189b013fA2B6C);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3LlamaProposal_20230803/CANCEL_LLAMA_STREAM.md'
      )
    );
  }
}
