// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Metis} from 'aave-address-book/AaveAddressBook.sol';

/**
 * @title Allow Emergency Admin Freeze
 * @author BGD labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Metis_AllowEmergencyAdminFreeze_20230829 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Metis.POOL_ADDRESSES_PROVIDER.setPoolConfiguratorImpl(address(0));
  }
}
