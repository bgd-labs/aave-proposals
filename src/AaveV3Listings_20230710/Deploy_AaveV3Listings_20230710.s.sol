// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3OPListings_20230710_Payload} from './AaveV3OPListings_20230710_Payload.sol';

contract DeployAaveV3OPListings_20230710_Payload is OptimismScript {
  function run() external broadcast {
    new AaveV3OPListings_20230710_Payload();
  }
}

contract DeployAaveV3OPListings_20230710_Proposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildOptimism(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV3Listings_20230710/LIST-RETH-OPTIMISM-V3.md')
    );
  }
}
