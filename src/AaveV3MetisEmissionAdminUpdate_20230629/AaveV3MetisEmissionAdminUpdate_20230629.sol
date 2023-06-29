// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

/**
 * @title AaveV3MetisEmissionAdminUpdate_20230629
 * @author @t0mcr8se Metis L2
 * @dev Sets Emission Admin for METIS token on Aave V3 Metis liquidity pool.
 * Once executed this payload would add an EMISSION_ADMIN for METIS token on the Metis EMISSION_MANAGER.
 */
contract AaveV3MetisEmissionAdminUpdate_20230629 is IProposalGenericExecutor {
  IEmissionManager public constant EMISSION_MANAGER = IEmissionManager(AaveV3Metis.EMISSION_MANAGER);

  address public constant METIS = AaveV3MetisAssets.Metis_UNDERLYING;
  address public constant EMISSION_ADMIN = 0x97177cD80475f8b38945c1E77e12F0c9d50Ac84D;

  function execute() public {
    EMISSION_MANAGER.setEmissionAdmin(METIS, EMISSION_ADMIN);
  }
}