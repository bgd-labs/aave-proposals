// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title CapsUpgrade_20230904
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: no snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-aave-v3-caps-increase-2023-08-31/14698
 */
contract AaveV3_Arbitrum_CapsUpgrade_20230904_20230904 is AaveV3PayloadArbitrum {
  function _preExecute() internal override {}

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3ArbitrumAssets.AAVE_UNDERLYING,
      supplyCap: 2_710,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
