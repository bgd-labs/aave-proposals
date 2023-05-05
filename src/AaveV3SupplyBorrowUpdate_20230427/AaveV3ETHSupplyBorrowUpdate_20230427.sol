// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title update wstETH Borrow cap on Aave V3 Ethereum
 * @author @ChaosLabsInc 
 * - Snapshot: Direct-to-AIP framework
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-supply-and-borrow-cap-updates-04-21-2023/12845/1
 */
contract AaveV3ETHSupplyBorrowUpdate_20230427 is AaveV3PayloadEthereum {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 12_000
    });

    return capsUpdate;
  }
}
