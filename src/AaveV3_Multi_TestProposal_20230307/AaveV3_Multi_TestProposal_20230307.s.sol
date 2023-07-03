// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3EthTestProposal20230307} from './AaveV3EthTestProposal20230307.sol';
import {AaveV3PolTestProposal20230307} from './AaveV3PolTestProposal20230307.sol';

contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3EthTestProposal20230307();
  }
}

contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolTestProposal20230307();
  }
}

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(address(0));
payloads[1] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Multi_TestProposal_20230307/TestProposal.md'));
  }
}