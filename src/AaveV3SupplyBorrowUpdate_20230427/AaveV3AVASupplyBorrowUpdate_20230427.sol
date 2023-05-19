// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3PayloadAvalanche, IEngine, EngineFlags, AaveV3AvalancheAssets } from 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';

/**
 * @title update WAVAX borrow caps on Aave V3 Avalanche
 * @author @ChaosLabsInc 
 * - Snapshot: Direct-to-AIP framework
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-supply-and-borrow-cap-updates-04-21-2023/12845/1
 */
contract AaveV3AVASupplyBorrowUpdate_20230427 is AaveV3PayloadAvalanche {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3AvalancheAssets.WAVAX_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 2_400_000
    });

    return capsUpdate;
  }
}
