// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {
  EthereumScript,
  OptimismScript,
  ArbitrumScript
} from 'aave-helpers/ScriptUtils.sol';
import {
  AaveV3OptimismUpdate20231002wethPayload
} from './AaveV3Optimism_20231002weth.sol';
import {
  AaveV3ArbitrumUpdate20231002wethPayload
} from './AaveV3Arbitrum_20231002weth.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildOptimism(0xc12aD8B3D242B1EDdc1C8319D1d58608E67043eD);
    payloads[1] = GovHelpers.buildArbitrum(0x0568a3aeb8E78262dEFf75ee68fAC20ae35ffA91);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3Update_20231002weth/AaveV3Update_20231002weth.md'
      )
    );
  }
}

contract Deploy20231002wethPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3OptimismUpdate20231002wethPayload();
  }
}

contract Deploy20231002wethPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbitrumUpdate20231002wethPayload();
  }
}
