// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IPoolConfigurator, AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';


/**
 * @title TODO
 * @author Chaos Labs
 * - Snapshot: N/A Urgent Risk Update 
 * - Discussion: https://governance.aave.com/t/post-vyper-exploit-crv-market-update-and-recommendations/14214/42 
 */
contract AaveV3_Eth_DisableCRVBorrows_20230508 is AaveV3PayloadEthereum {
    function borrowsUpdates() public pure override returns (IEngine.BorrowUpdate[] memory) {
        IEngine.BorrowUpdate[] memory borrowsUpdate = new IEngine.BorrowUpdate[](1);

        borrowsUpdate[0] = IEngine.BorrowUpdate({
            asset: AaveV3EthereumAssets.CRV_UNDERLYING,
            reserveFactor: EngineFlags.KEEP_CURRENT,
            enabledToBorrow: EngineFlags.DISABLED,
            flashloanable: EngineFlags.KEEP_CURRENT,
            stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
            borrowableInIsolation: EngineFlags.KEEP_CURRENT,
            withSiloedBorrowing: EngineFlags.KEEP_CURRENT
        });

        return borrowsUpdate;
    }
}