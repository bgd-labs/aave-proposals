// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
// import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
// import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

import 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';

/**
* @title This proposal changes WBTC and DAI risk params
 * @author @Maltmark chaos labs
* - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-optimism-2023-03-22/12421
*/
contract AaveV3OPRiskParams_20230330 is AaveV3PayloadOptimism {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](2);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.WBTC_UNDERLYING,
      ltv: 73_00,
      liqThreshold: 78_00,
      liqBonus: 8_50,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    collateralUpdate[1] = IEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.DAI_UNDERLYING,
      ltv: 78_00,
      liqThreshold: 83_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }


}
