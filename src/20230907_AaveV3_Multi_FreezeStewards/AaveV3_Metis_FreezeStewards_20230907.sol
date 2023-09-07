// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

/**
 * @title Freeze Stewards
 * @author BGD Labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Metis_FreezeStewards_20230907 is IProposalGenericExecutor {
  address public immutable FREEZING_STEWARD;

  constructor(address freezingSteward) {
    FREEZING_STEWARD = freezingSteward;
  }

  function execute() external {
    AaveV3Metis.ACL_MANAGER.addRiskAdmin(FREEZING_STEWARD);
  }
}
