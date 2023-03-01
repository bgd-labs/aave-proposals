// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Update Risk Params for MaticX on Aave V3 Polygon
 * @author Llama
 * @dev This proposal updates multiple risk parameters for the MaticX pool on Aave V3 Polygon
 * Governance: https://governance.aave.com/t/arfc-maticx-polygon-v3-upgrade/11555
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x8abe6a2ae1134d6886f460d6648dc3a5d2f789e1b94e78f496e7f5ec5ff38697
 */
contract AaveV3PolMaticXRiskParamsUpdatePayload is IProposalGenericExecutor {
  uint256 public constant NEW_SUPPLY_CAP = 8_600_000;
  uint256 public constant NEW_BORROW_CAP = 5_200_000;
  uint256 public constant NEW_LIQ_FEE = 10_00;
  uint256 public constant NEW_LTV = 58_00;
  uint256 public constant NEW_LIQ_THRESHOLD = 67_00;
  uint256 public constant NEW_LIQ_BONUS = 1_10_00;
  address public constant NEW_INTEREST_RATE_STRATEGY = 0x6B434652E4C4e3e972f9F267982F05ae0fcc24b6;

  function execute() external {
    AaveV3Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      NEW_LTV,
      NEW_LIQ_THRESHOLD,
      NEW_LIQ_BONUS
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      NEW_BORROW_CAP
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setLiquidationProtocolFee(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      NEW_LIQ_FEE
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveBorrowing(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      true
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      NEW_INTEREST_RATE_STRATEGY
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      NEW_SUPPLY_CAP
    );
  }
}
