// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @author @yonikesel - Chaos Labs Inc
 * - Snapshot: Direct to AIP
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-stewards-increase-caps-reth-and-wsteth-on-v3-arbitrum/13817
 */
contract AaveV3ArbwstETHCapsUpdates_20230703 is AaveV3PayloadArbitrum {
  uint256 public constant NEW_SUPPLY_CAP_WSTETH = 30_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP_WSTETH,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
