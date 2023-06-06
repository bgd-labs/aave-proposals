// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {ArbitrumScript, OptimismScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ARBMAIFixes_20230606} from './AaveV3ARBMAIFixes_20230606.sol';
import {AaveV3OPMAIFixes_20230606} from './AaveV3OPMAIFixes_20230606.sol';

contract DeployAaveV3OPMAIListing_20230425 is OptimismScript {
  function run() external broadcast {
    new AaveV3OPMAIFixes_20230606();
  }
}

contract DeployAaveV3ARBMAIListing_20230425 is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ARBMAIFixes_20230606();
  }
}

contract CreateAaveV3OPMAIListing_20230425 is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildOptimism(address(0));
    payloads[1] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV3OPARBMAIFixes_20230606/MAI-TOKEN_IMPL_FIX.md')
    );
  }
}
