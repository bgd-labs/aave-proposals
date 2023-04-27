// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {
  AaveV3PayloadEthereum,
  IEngine,
  EngineFlags,
  AaveV3EthereumAssets
} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

contract AaveV3EthUpdate20230327Payload is AaveV3PayloadEthereum {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](2);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.rETH_UNDERLYING,
      // previous value: 10_000
      supplyCap: 20_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    capsUpdate[1] = IEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.CRV_UNDERLYING,
      // previous value: 62_500_000
      supplyCap: 51_000_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
