// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title Freeze Stewards
 * @author BGD Labs
 * - Discussion: https://governance.aave.com/t/temporarily-pausing-gho-integration-in-aave/14626/8
 */
contract AaveV3_Polygon_FreezeStewards_20230907 is IProposalGenericExecutor {
  address public immutable FREEZING_STEWARD;

  constructor(address freezingSteward) {
    FREEZING_STEWARD = freezingSteward;
  }

  function execute() external {
    AaveV3Polygon.ACL_MANAGER.addRiskAdmin(FREEZING_STEWARD);
  }
}
