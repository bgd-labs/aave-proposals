// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadOptimism, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title Supply Cap increase - wstETH
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: No snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-supply-cap-increase-wsteth/14376/1
 */
contract AaveV3_Opt_wstETH_CapsIncrease_20230908 is AaveV3PayloadOptimism {
  uint256 public constant NEW_SUPPLY_CAP = 34_500;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3OptimismAssets.wstETH_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
