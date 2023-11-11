// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadMetis, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadMetis.sol';
import {AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';

/**
 * @title CapsUpgrade_20230904
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: no snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-aave-v3-caps-increase-2023-08-31/14698
 */
contract AaveV3_Metis_CapsUpgrade_20230904_20230904 is AaveV3PayloadMetis {
  function _preExecute() internal override {}

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3MetisAssets.Metis_UNDERLYING,
      supplyCap: 120_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
