// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';

/**
 * @dev Aave governance payload to freeze the jEUR asset on Aave v3 Polygon
 * - Snapshot: N/A Urgent proposal
 * - Dicussion: https://governance.aave.com/t/jeur-incident-plan-of-action/11379
 */
contract AaveV3PolFreezeJEUR is IProposalGenericExecutor {
  address public constant JEUR = 0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c;

  function execute() external {
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(JEUR, true);
  }
}
