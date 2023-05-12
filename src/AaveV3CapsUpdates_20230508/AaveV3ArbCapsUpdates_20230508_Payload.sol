// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title AaveV3ArbCapsUpdates_20230508_Payload
 * @author Llama
 * @dev Update the Aave V3 Arbitrum wstETH supply cap
 * Forum: https://governance.aave.com/t/arfc-wsteth-supply-cap-increase-arbitrum-v3/13016
 */
contract AaveV3ArbCapsUpdates_20230508_Payload is AaveV3PayloadArbitrum {
  uint256 public constant NEW_SUPPLY_CAP = 9_300;

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
