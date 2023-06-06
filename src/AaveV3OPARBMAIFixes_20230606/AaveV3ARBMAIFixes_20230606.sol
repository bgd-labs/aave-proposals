// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ConfiguratorInputTypes} from 'aave-v3-core/contracts/protocol/libraries/types/ConfiguratorInputTypes.sol';

contract AaveV3ARBMAIFixes_20230606 is IProposalGenericExecutor {

  function execute() external {
    AaveV3Arbitrum.POOL_CONFIGURATOR.updateAToken(
      ConfiguratorInputTypes.UpdateATokenInput({
        asset: AaveV3ArbitrumAssets.MAI_UNDERLYING,
        treasury: address(AaveV3Arbitrum.COLLECTOR),
        incentivesController: address(AaveV3Arbitrum.DEFAULT_INCENTIVES_CONTROLLER),
        name: 'Aave Arbitrum MAI',
        symbol: 'aArbMAI',
        implementation: AaveV3Arbitrum.DEFAULT_A_TOKEN_IMPL_REV_2,
        params: bytes('')
      })
    );
  }
}
