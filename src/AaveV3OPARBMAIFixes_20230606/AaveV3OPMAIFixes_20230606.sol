// SPDX-License-Identifier: MIT
pragma solidity <0.8.20;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ConfiguratorInputTypes} from 'aave-v3-core/contracts/protocol/libraries/types/ConfiguratorInputTypes.sol';

contract AaveV3OPMAIFixes_20230606 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Optimism.POOL_CONFIGURATOR.updateAToken(
      ConfiguratorInputTypes.UpdateATokenInput({
        asset: AaveV3OptimismAssets.MAI_UNDERLYING,
        treasury: address(AaveV3Optimism.COLLECTOR),
        incentivesController: address(AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER),
        name: 'Aave Optimism MAI',
        symbol: 'aOptMAI',
        implementation: AaveV3Optimism.DEFAULT_A_TOKEN_IMPL_REV_2,
        params: bytes('')
      })
    );

    AaveV3Optimism.POOL_CONFIGURATOR.updateStableDebtToken(
      ConfiguratorInputTypes.UpdateDebtTokenInput({
        asset: AaveV3OptimismAssets.MAI_UNDERLYING,
        incentivesController: address(AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER),
        name: 'Aave Optimism Stable Debt MAI',
        symbol: 'stableDebtOptMAI',
        implementation: AaveV3Optimism.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_2,
        params: bytes('')
      })
    );

    AaveV3Optimism.POOL_CONFIGURATOR.updateVariableDebtToken(
      ConfiguratorInputTypes.UpdateDebtTokenInput({
        asset: AaveV3OptimismAssets.MAI_UNDERLYING,
        incentivesController: address(AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER),
        name: 'Aave Optimism Variable Debt MAI',
        symbol: 'variableDebtOptMAI',
        implementation: AaveV3Optimism.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
        params: bytes('')
      })
    );

    AaveV3Optimism.POOL_CONFIGURATOR.setReservePause(AaveV3OptimismAssets.MAI_UNDERLYING, false);

    AaveV3Optimism.POOL_CONFIGURATOR.setReserveFlashLoaning(
      AaveV3OptimismAssets.MAI_UNDERLYING,
      true
    );
  }
}
