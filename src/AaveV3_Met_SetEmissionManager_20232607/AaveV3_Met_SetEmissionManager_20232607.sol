// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadMetis, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadMetis.sol';
import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Set Metis Foundation Wallet as Emission Manager for METIS Token on Aave V3 Metis Pool
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xf34db3fe2401c061e822177856e55c9df34d065610c29d1ebac1513c3c8eb9ee
 * - Discussion: https://governance.aave.com/t/arfc-set-metis-foundation-wallet-as-emission-manager-for-metis-token-on-aave-v3-metis-pool/13912
 */
contract AaveV3_Met_SetEmissionManager_20232607 {
  address public constant METIS = AaveV3MetisAssets.Metis_UNDERLYING;
  address public constant EMISSION_ADMIN = 0x97177cD80475f8b38945c1E77e12F0c9d50Ac84D;

  function execute() external {
    IEmissionManager(AaveV3Metis.EMISSION_MANAGER).setEmissionAdmin(METIS, EMISSION_ADMIN);
  }
}
