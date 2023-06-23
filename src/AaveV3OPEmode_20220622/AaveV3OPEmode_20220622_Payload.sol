// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title Add Optimism V3 EMode Category
 * @author Llama
 * @dev This proposal adds an ETH Correlated EMode category to Optimism V3
 * Governance: https://governance.aave.com/t/arfc-optimism-create-eth-e-mode/13144
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x68e950fd00629176ee7f1b9f5b05e601eb12453d2fa553c214248a9999d63dd8
 */
contract AaveV3OPEmode_20220622_Payload is IProposalGenericExecutor {
  string public constant EMODE_LABEL_ETH_CORRELATED = 'ETH correlated';
  uint16 public constant EMODE_LTV_ETH_CORRELATED = 90_00;
  uint16 public constant EMODE_LT_ETH_CORRELATED = 93_00;
  uint16 public constant EMODE_LBONUS_ETH_CORRELATED = 10_100;
  uint8 public constant EMODE_CATEGORY_ID_ETH_CORRELATED = 2;

  function execute() external {
    AaveV3Optimism.POOL_CONFIGURATOR.setEModeCategory(
      EMODE_CATEGORY_ID_ETH_CORRELATED,
      EMODE_LTV_ETH_CORRELATED,
      EMODE_LT_ETH_CORRELATED,
      EMODE_LBONUS_ETH_CORRELATED,
      address(0),
      EMODE_LABEL_ETH_CORRELATED
    );

    AaveV3Optimism.POOL_CONFIGURATOR.setAssetEModeCategory(
      AaveV3OptimismAssets.WETH_UNDERLYING,
      EMODE_CATEGORY_ID_ETH_CORRELATED
    );

    AaveV3Optimism.POOL_CONFIGURATOR.setAssetEModeCategory(
      AaveV3OptimismAssets.wstETH_UNDERLYING,
      EMODE_CATEGORY_ID_ETH_CORRELATED
    );
  }
}
