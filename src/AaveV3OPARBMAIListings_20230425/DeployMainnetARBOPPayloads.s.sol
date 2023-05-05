// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {ArbitrumScript, OptimismScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3OPMAIListing_20230425} from './AaveV3OPMAIListing_20230425.sol';
import {AaveV3ARBMAIListing_20230425} from './AaveV3ARBMAIListing_20230425.sol';

contract DeployAaveV3OPMAIListing_20230425 is OptimismScript {
  function run() external broadcast {
    new AaveV3OPMAIListing_20230425();
  }
}

contract DeployAaveV3ARBMAIListing_20230425 is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ARBMAIListing_20230425();
  }
}

contract CreateAaveV3OPMAIListing_20230425 is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildOptimism(
      address(0) // deployed MAI payload
    );
    GovHelpers.createProposal(
      payloads,
      0 // TODO: Replace with actual hash
    );
  }
}

contract CreateAaveV3ARBMAIListing_20230425 is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildArbitrum(
      address(0) // deployed MAI payload
    );
    GovHelpers.createProposal(
      payloads,
      0 // TODO: Replace with actual hash
    );
  }
}

