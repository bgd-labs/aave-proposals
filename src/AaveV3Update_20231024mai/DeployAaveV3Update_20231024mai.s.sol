// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, ArbitrumScript, OptimismScript, PolygonScript, AvalancheScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3ArbitrumUpdate20231024maiPayload} from './AaveV3Arbitrum_20231024mai.sol';
import {AaveV3OptimismUpdate20231024maiPayload} from './AaveV3Optimism_20231024mai.sol';
import {AaveV3PolygonUpdate20231024maiPayload} from './AaveV3Polygon_20231024mai.sol';
import {AaveV3AvalancheUpdate20231024maiPayload} from './AaveV3Avalanche_20231024mai.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildArbitrum(address(0));
    payloads[1] = GovHelpers.buildOptimism(address(0));
    payloads[2] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV3Update_20231024mai/AaveV3Update_20231024mai.md')
    );
  }
}

contract Deploy20231024maiPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbitrumUpdate20231024maiPayload();
  }
}

contract Deploy20231024maiPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3OptimismUpdate20231024maiPayload();
  }
}

contract Deploy20231024maiPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolygonUpdate20231024maiPayload();
  }
}

contract Deploy20231024maiPayloadAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3AvalancheUpdate20231024maiPayload();
  }
}
