// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadOptimism, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';


/**
 * @title Enable borrow of OP token
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x617adb838ce95e319f06f72e177ad62cd743c2fe3fd50d6340dfc8606fbdd0b3
 * - Discussion: https://governance.aave.com/t/arfc-op-risk-parameters-update-aave-v3-optimism-pool/14633
 */
contract AaveV3_Optimism_EnableBorrowOfOPToken_20231016 is AaveV3PayloadOptimism {
  function borrowsUpdates() public pure override returns (IEngine.BorrowUpdate[] memory) {
    IEngine.BorrowUpdate[] memory borrowsUpdate = new IEngine.BorrowUpdate[](1);
    
    borrowsUpdate[0] = IEngine.BorrowUpdate({
      asset: AaveV3OptimismAssets.OP_UNDERLYING,
      reserveFactor: EngineFlags.KEEP_CURRENT,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT
    });
    
    return borrowsUpdate;
    }
}
