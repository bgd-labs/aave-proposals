// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';

/**
 * @title Update borrow and supply caps on Aave V3 Avalanche
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x833eca942053ffcaecbedd6c3b0d5f2392f1ad868e57f1babe9b40a2afedaaa3
 * - Discussion: https://governance.aave.com/t/arc-gauntlet-risk-parameter-recommendations-2023-03-20/12385/5
 */
contract AaveV3AvaCapsUpdate_20230411 is AaveV3PayloadAvalanche {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](3);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3AvalancheAssets.BTCb_UNDERLYING,
      supplyCap: 3000,
      borrowCap: 900
    });

    capsUpdate[1] = IEngine.CapsUpdate({
      asset: AaveV3AvalancheAssets.USDC_UNDERLYING,
      supplyCap: 170_000_000,
      borrowCap: 90_000_000
    });

    capsUpdate[2] = IEngine.CapsUpdate({
      asset: AaveV3AvalancheAssets.DAIe_UNDERLYING,
      supplyCap: 17_000_000,
      borrowCap: 17_000_000
    });

    return capsUpdate;
  }
}
