// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';

/**
 * @title Update Supply and Borrow caps on Aave V3 Optimism
 * @author @yonikesel - Chaos Labs
 * - Snapshot: Direct-to-AIP framework
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-supply-and-borrow-cap-updates-03-30-2023/12532
 */
contract AaveV3OptSupplyCapsUpdate_20230330 is AaveV3PayloadOptimism {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3OptimismAssets.wstETH_UNDERLYING,
      supplyCap: 12_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
