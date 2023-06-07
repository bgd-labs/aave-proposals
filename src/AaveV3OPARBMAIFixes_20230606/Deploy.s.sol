// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {ArbitrumScript, OptimismScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ARBMAIFixes_20230606} from './AaveV3ARBMAIFixes_20230606.sol';
import {AaveV3OPMAIFixes_20230606} from './AaveV3OPMAIFixes_20230606.sol';

contract DeployAaveV3OPMAIFixes_20230606 is OptimismScript {
  function run() external broadcast {
    new AaveV3OPMAIFixes_20230606();
  }
}

contract DeployAaveV3ARBMAIFixes_20230606 is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ARBMAIFixes_20230606();
  }
}

contract CreateMaiFixesProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildOptimism(0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7);
    payloads[1] = GovHelpers.buildArbitrum(0x9441B65EE553F70df9C77d45d3283B6BC24F222d);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV3OPARBMAIFixes_20230606/MAI-TOKEN_IMPL_FIX.md')
    );
  }
}
