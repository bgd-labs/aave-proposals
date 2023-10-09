// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadAvalanche, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';

/**
 * @title Enabling USDT as collateral on Aave v3 AVAX Market
 * @author Marc Zeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x5623b5f84f021ad787033b4a1efd9e2de417004d27c5f2e3d7351f9b575574b1
 * - Discussion: https://governance.aave.com/t/arfc-enabling-usdt-as-collateral-on-aave-v3-avax-market/14632/3
 */
contract AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926 is
  AaveV3PayloadAvalanche
{
  uint256 public constant BORROW_CAP = 80_000_000; // 80M
  uint256 public constant SUPPLY_CAP = 100_000_000; // 100M
  uint256 public constant DEBT_CEILING = 0;

  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3AvalancheAssets.USDt_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: DEBT_CEILING,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });
    return collateralUpdate;
  }

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3AvalancheAssets.USDt_UNDERLYING,
      borrowCap: BORROW_CAP,
      supplyCap: SUPPLY_CAP
    });

    return capsUpdate;
  }
}
