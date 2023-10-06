// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadAvalanche, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {AaveV3AvalancheEModes} from 'aave-address-book/AaveV3Avalanche.sol';

/**
 * @title Test proposal
 * @author BGD labs
 * - Snapshot: https://test
 * - Discussion: https://test
 */
contract AaveV3Avalanche_TestProposal_20231006 is AaveV3PayloadAvalanche {
  function _preExecute() internal override {}

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IEngine.EModeCategoryUpdate[] memory)
  {
    IEngine.EModeCategoryUpdate[] memory eModeUpdates = new IEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3AvalancheEModes.AVAX_CORRELATED,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 99_99,
      liqBonus: EngineFlags.KEEP_CURRENT,
      priceSource: EngineFlags.KEEP_CURRENT_ADDRESS,
      label: KEEP_CURRENT_STRING
    });

    return eModeUpdates;
  }
}
