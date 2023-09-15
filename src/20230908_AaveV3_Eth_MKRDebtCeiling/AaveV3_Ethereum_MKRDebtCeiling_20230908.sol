// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title MKRDebtCeiling
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: No snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-borrowing-cap-expansion-request-mkr/14763
 */
contract AaveV3_Ethereum_MKRDebtCeiling_20230908 is AaveV3PayloadEthereum {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.MKR_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: 6_000_000,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
