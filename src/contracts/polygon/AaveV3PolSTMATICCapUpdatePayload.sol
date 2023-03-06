// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Update AAVE V3 Polygon stMatic Supply Cap
 * @author Llama
 * @dev This payload sets supply caps for stMatic assets on AAVE V3 Polygon
 * - Discussion stMatic: https://governance.aave.com/t/arfc-increase-stmatic-supply-cap/12038
 */
contract AaveV3PolSTMATICCapUpdatePayload is IProposalGenericExecutor {
  uint256 public constant STMATIC_SUPPLY_CAP = 15_000_000;

  function execute() external {
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(
      AaveV3PolygonAssets.stMATIC_UNDERLYING,
      STMATIC_SUPPLY_CAP
    );
  }
}
