// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';

/**
 * @title Allow Emergency Admin Freeze
 * @author BGD labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Optimism_AllowEmergencyAdminFreeze_20230829 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Optimism.POOL_ADDRESSES_PROVIDER.setPoolConfiguratorImpl(address(0));
  }
}
