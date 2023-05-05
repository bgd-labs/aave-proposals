// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3PayloadOptimism, IEngine, Rates, EngineFlags, AaveV3OptimismAssets } from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';

/**
 * @title update wstETH and WBTC supply caps on Aave V3 Optimism
 * @author @ChaosLabsInc 
 * - Snapshot: Direct-to-AIP framework
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-supply-and-borrow-cap-updates-04-21-2023/12845/1
 */
contract AaveV3OPSupplyBorrowUpdate_20230427 is AaveV3PayloadOptimism {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](2);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3OptimismAssets.WBTC_UNDERLYING,
      supplyCap: 1_200,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    capsUpdate[1] = IEngine.CapsUpdate({
      asset: AaveV3OptimismAssets.wstETH_UNDERLYING,
      supplyCap: 12_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
