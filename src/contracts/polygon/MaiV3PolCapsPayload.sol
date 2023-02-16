// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal change Mai supply & borrow caps on Aave V3 Polygon
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe1619dbffa3b6075f3c06308d45d3fb2260d1d0e93fee3eeec4ab84a98c4511c
 * - Discussion: https://governance.aave.com/t/arfc-increase-borrow-cap-for-mai-aave-polygon-v3/11547
 */

contract MAIV3PolCapsPayload is IProposalGenericExecutor {
  address public constant MAI = AaveV3PolygonAssets.miMATIC_UNDERLYING;

  uint256 public constant MAI_SUPPLY_CAP = 1_100_000;
  uint256 public constant MAI_BORROW_CAP = 600_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Polygon.POOL_CONFIGURATOR;

    configurator.setSupplyCap(MAI, MAI_SUPPLY_CAP);
    configurator.setBorrowCap(MAI, MAI_BORROW_CAP);
  }
}
