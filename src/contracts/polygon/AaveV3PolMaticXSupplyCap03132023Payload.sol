// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Update Supply Cap for MaticX on Aave V3 Polygon
 * @author Llama
 * @dev This proposal updates supply cap parameter for the MaticX pool on Aave V3 Polygon
 * Governance: https://governance.aave.com/t/arfc-maticx-supplycap-increase-polygon-v3/12217
 */
contract AaveV3PolMaticXSupplyCap03132023Payload is IProposalGenericExecutor {
  uint256 public constant NEW_SUPPLY_CAP = 17_200_000;

  function execute() external {
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      NEW_SUPPLY_CAP
    );
  }
}
