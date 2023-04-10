// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @dev change 4 stable asset to be in borrowable isolation mode - usdc, usdt, dai and lusd
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xef5eed1bdda3a7d6ea2b37b09c7de1960530bb54f24ddc6c7b002447251b6bb4
 * - Discussion: https://governance.aave.com/t/arfc-configure-isolation-mode-borrowable-assets-v3-ethereum/12420
 */
contract AaveV3ETHIsoMode_20230330 is AaveV3PayloadEthereum {
  function borrowsUpdates() public pure override returns (IEngine.BorrowUpdate[] memory) {
    IEngine.BorrowUpdate[] memory borrowsUpdate = new IEngine.BorrowUpdate[](4);

    borrowsUpdate[0] = IEngine.BorrowUpdate({
      asset: AaveV3EthereumAssets.USDC_UNDERLYING,
      reserveFactor: EngineFlags.KEEP_CURRENT,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT
    });

    borrowsUpdate[1] = IEngine.BorrowUpdate({
      asset: AaveV3EthereumAssets.USDT_UNDERLYING,
      reserveFactor: EngineFlags.KEEP_CURRENT,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT
    });

    borrowsUpdate[2] = IEngine.BorrowUpdate({
      asset: AaveV3EthereumAssets.DAI_UNDERLYING,
      reserveFactor: EngineFlags.KEEP_CURRENT,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT
    });

    borrowsUpdate[3] = IEngine.BorrowUpdate({
      asset: AaveV3EthereumAssets.LUSD_UNDERLYING,
      reserveFactor: EngineFlags.KEEP_CURRENT,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT
    });
    return borrowsUpdate;
  }
}
