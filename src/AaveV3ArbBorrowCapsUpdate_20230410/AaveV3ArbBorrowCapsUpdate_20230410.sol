// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title Update wstETH borrow cap on Aave V3 Arbitrum
 * @author Gauntlet
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/arc-gauntlet-recommendations-for-wsteth-on-aave-v3-arbitrum/12675
 */
contract AaveV3ArbBorrowCapsUpdate_20230410 is AaveV3PayloadArbitrum {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 800
    });

    return capsUpdate;
  }
}
