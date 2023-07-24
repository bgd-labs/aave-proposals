// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {GovHelpers, AaveGovernanceV2} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbMAICapsUpdates_20230724} from './AaveV3ArbMAICapsUpdates_20230724.sol';
import {AaveV3AvaxMAICapsUpdates_20230724} from './AaveV3AvaxMAICapsUpdates_20230724.sol';
import {AaveV3OptMAICapsUpdates_20230724} from './AaveV3OptMAICapsUpdates_20230724.sol';
import {AaveV3PolMAICapsUpdates_20230724} from './AaveV3PolMAICapsUpdates_20230724.sol';
import 'aave-helpers/ScriptUtils.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildPolygon(address(0));
    payloads[1] = GovHelpers.buildOptimism(address(0));
    payloads[2] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3PolCRVRiskParams_20230702/CHAOS-LABS-RISK-PARAMETERS-UPDATE-CRV-AAVE-V3-POLYGON.md'
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
