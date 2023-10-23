// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2EthUnifyFallbackOracles20230507} from './AaveV2EthUnifyFallbackOracles20230507.sol';

// make deploy-ledger contract=src/AaveV2_Eth_UnifyFallbackOracles_20230507/AaveV2_Eth_UnifyFallbackOracles_20230507.s.sol:DeployEthereum chain=mainnet
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2EthUnifyFallbackOracles20230507();
  }
}

// make deploy-ledger contract=src/AaveV2_Eth_UnifyFallbackOracles_20230507/AaveV2_Eth_UnifyFallbackOracles_20230507.s.sol:CreateProposal chain=mainnet
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x4fe817deCEf9f6E793370FC057A7DA6BC0fEdFA7);
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV2_Eth_UnifyFallbackOracles_20230507/UnifyFallbackOracles.md'));
  }
}