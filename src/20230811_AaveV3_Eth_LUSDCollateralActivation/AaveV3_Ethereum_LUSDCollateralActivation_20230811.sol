// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title LUSD collateral activation
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4e17faf4fdb1ea2c8974d19e710724daf98dde225cd2078a9af4fbb5f0895512
 * - Discussion: https://governance.aave.com/t/arfc-activate-lusd-as-collateral-on-aave-v3-eth-pool/14199
 */
contract AaveV3_Ethereum_LUSDCollateralActivation_20230811 is AaveV3PayloadEthereum {

    
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.LUSD_UNDERLYING,
      ltv: 77_00,
      liqThreshold: 80_00,
      liqBonus: 4_50,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: 10_00,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}