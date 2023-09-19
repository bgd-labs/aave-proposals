// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadAvalanche, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';

/**
 * @title Chaos Labs Risk Parameter Updates Aave V3 Avalanche
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0c7fc4246c5795a9d9901c08a9a8279e7e6ed1069f2155fe48239c92e4e43193
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-avalanche-2023-09-06/14774/1
 */
contract AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918 is
  AaveV3PayloadAvalanche
{
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](3);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3AvalancheAssets.WAVAX_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: 9_00,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IEngine.CollateralUpdate({
      asset: AaveV3AvalancheAssets.sAVAX_UNDERLYING,
      ltv: 30_00,
      liqThreshold: 40_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[2] = IEngine.CollateralUpdate({
      asset: AaveV3AvalancheAssets.LINKe_UNDERLYING,
      ltv: 56_00,
      liqThreshold: 71_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
