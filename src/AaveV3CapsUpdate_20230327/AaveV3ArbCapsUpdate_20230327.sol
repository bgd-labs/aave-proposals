// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {
  AaveV3PayloadArbitrum,
  IEngine,
  EngineFlags,
  AaveV3ArbitrumAssets
} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

contract AaveV3ArbUpdate20230327Payload is AaveV3PayloadArbitrum {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3ArbitrumAssets.WETH_UNDERLYING,
      // previous value: 35,280
      supplyCap: 45000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
