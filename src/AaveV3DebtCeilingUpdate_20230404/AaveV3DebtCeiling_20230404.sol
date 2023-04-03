// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @dev Payload for updating the debt ceiling of EURS on Polygon
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb1f8b1814d9c09760daa4d7e9fa90d906b2c9ff5fbd20c8d0f5793c4f5cc4999
 * - Discussion: https://governance.aave.com/t/gauntlet-aave-v3-isolation-mode-methodology/12290
 */
contract AaveV3PolDebtCeiling_20230404 is AaveV3PayloadPolygon {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralsUpdate = new IEngine.CollateralUpdate[](1);

    collateralsUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.EURS_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: 675_000,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralsUpdate;
  }
}

/**
 * @dev Payload for updating the debt ceiling of EURS and USDT on Arbitrum
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb1f8b1814d9c09760daa4d7e9fa90d906b2c9ff5fbd20c8d0f5793c4f5cc4999
 * - Discussion: https://governance.aave.com/t/gauntlet-aave-v3-isolation-mode-methodology/12290
 */
contract AaveV3ArbDebtCeiling_20230404 is AaveV3PayloadArbitrum {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralsUpdate = new IEngine.CollateralUpdate[](2);

    collateralsUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3ArbitrumAssets.USDT_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: 2_500_000,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    collateralsUpdate[1] = IEngine.CollateralUpdate({
      asset: AaveV3ArbitrumAssets.EURS_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: 25_000,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralsUpdate;
  }
}
