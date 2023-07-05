// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3EthTestProposal20230507} from './AaveV3EthTestProposal20230507.sol';
import {AaveV3PolTestProposal20230507} from './AaveV3PolTestProposal20230507.sol';

/**
 * @dev Deploy AaveV3EthTestProposal20230507
 * command: make deploy-ledger contract=src/AaveV3_Multi_TestProposal_20230507/AaveV3_Multi_TestProposal_20230507.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3EthTestProposal20230507();
  }
}

/**
 * @dev Deploy AaveV3PolTestProposal20230507
 * command: make deploy-ledger contract=src/AaveV3_Multi_TestProposal_20230507/AaveV3_Multi_TestProposal_20230507.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolTestProposal20230507();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Multi_TestProposal_20230507/AaveV3_Multi_TestProposal_20230507.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(address(0));
payloads[1] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Multi_TestProposal_20230507/TestProposal.md'));
  }
}