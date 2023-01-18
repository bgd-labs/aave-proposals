// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';

/**
 * @dev Aave governance payload to freeze the agEUR asset on Aave v3 Polygon
 * - Snapshot: N/A Urgent proposal
 * - Dicussion: https://governance.aave.com/t/jeur-incident-plan-of-action/11379
 */
contract AaveV3PolFreezeAGEUR is IProposalGenericExecutor {
  address public constant AGEUR = 0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4;

  function execute() external {
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AGEUR, true);
  }
}
