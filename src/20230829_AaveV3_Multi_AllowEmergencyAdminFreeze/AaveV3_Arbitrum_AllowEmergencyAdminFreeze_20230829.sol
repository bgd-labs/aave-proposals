// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveAddressBook.sol';

/**
 * @title Allow Emergency Admin Freeze
 * @author BGD labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829 is IProposalGenericExecutor {
  address public constant NEW_POOL_CONFIGURATOR_IMPL = address(0);
  
  function execute() external {
    AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER.setPoolConfiguratorImpl(NEW_POOL_CONFIGURATOR_IMPL);
  }
}
