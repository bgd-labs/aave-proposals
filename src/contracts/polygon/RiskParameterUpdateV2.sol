// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';

contract RiskParameterUpdateV2 is IProposalGenericExecutor {
  address public constant GHST = 0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7;

  function execute() external override {
    // polygon v2
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(GHST);
    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      GHST,
      2500,
      4000,
      11250
    );
  }
}
