// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, ArbitrumScript, AvalancheScript, OptimismScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3ArbMAICapsUpdates_20230724} from './AaveV3ArbMAICapsUpdates_20230724.sol';
import {AaveV3AvaxMAICapsUpdates_20230724} from './AaveV3AvaxMAICapsUpdates_20230724.sol';
import {AaveV3OptMAICapsUpdates_20230724} from './AaveV3OptMAICapsUpdates_20230724.sol';
import {AaveV3PolMAICapsUpdates_20230724} from './AaveV3PolMAICapsUpdates_20230724.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildPolygon(address(0)); // TODO: replace with deployed payload
    payloads[1] = GovHelpers.buildOptimism(address(0)); // TODO: replace with deployed payload
    payloads[2] = GovHelpers.buildArbitrum(address(0)); // TODO: replace with deployed payload
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3MAICapsUpdates_20230724/CHAOS-LABS-RISK-PARAMETERS-UPDATE-MAI-AAVE-V3.md'
      )
    );
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbMAICapsUpdates_20230724();
  }
}

contract DeployPayloadAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3AvaxMAICapsUpdates_20230724();
  }
}

contract DeployPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3OptMAICapsUpdates_20230724();
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolMAICapsUpdates_20230724();
  }
}
