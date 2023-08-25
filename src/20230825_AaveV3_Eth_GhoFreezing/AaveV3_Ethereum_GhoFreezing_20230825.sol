// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'lib/aave-address-book/src/AaveV3Ethereum.sol';

/**
 * @title GhoFreezing
 * @author BGD Labs
 * - Discussion: https://governance.aave.com/t/temporarily-pausing-gho-integration-in-aave/14626
 */
contract AaveV3_Ethereum_GhoFreezing_20230825 is IProposalGenericExecutor {
  address public immutable GUARDIAN_FREEZER;

  constructor(address freezingOnlyRiskAdmin) {
    GUARDIAN_FREEZER = freezingOnlyRiskAdmin;
  }

  function execute() external {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReservePause(AaveV3EthereumAssets.GHO_UNDERLYING, false);
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveFreeze(AaveV3EthereumAssets.GHO_UNDERLYING, true);
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(GUARDIAN_FREEZER);
  }
}
