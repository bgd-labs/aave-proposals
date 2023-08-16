// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadArbitrum, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title Supply Cap increase - wstETH
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: no snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-supply-cap-increase-wsteth/14376/1
 */
contract AaveV3_Arb_wstETH_CapsIncrease_20230908 is AaveV3PayloadArbitrum {
  uint256 public constant NEW_SUPPLY_CAP = 45_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
