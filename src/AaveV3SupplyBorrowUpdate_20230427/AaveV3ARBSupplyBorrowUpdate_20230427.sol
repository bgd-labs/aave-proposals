// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags, AaveV3ArbitrumAssets } from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title update WBTC and WETH caps on Aave V3 Arbitrum
 * @author @ChaosLabsInc 
 * - Snapshot: Direct-to-AIP framework
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-supply-and-borrow-cap-updates-04-21-2023/12845/1
 */
contract AaveV3ARBSupplyBorrowUpdate_20230427 is AaveV3PayloadArbitrum {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](2);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3ArbitrumAssets.WBTC_UNDERLYING,
      supplyCap: 4_200,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    capsUpdate[1] = IEngine.CapsUpdate({
      asset: AaveV3ArbitrumAssets.WETH_UNDERLYING,
      supplyCap: 70_000,
      borrowCap: 20_000
    });

    return capsUpdate;
  }
}
