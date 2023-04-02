// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title Update Supply and Borrow caps on Aave V3 Arbitrum
 * @author @yonikesel - Chaos Labs
 * - Snapshot: Direct-to-AIP framework
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-supply-and-borrow-cap-updates-03-30-2023/12532
 */
contract AaveV3ArbSupplyCapsUpdate_20230330 is AaveV3PayloadArbitrum {
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
      borrowCap: 22_000
    });

    return capsUpdate;
  }
}
