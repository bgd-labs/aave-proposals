// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This payload sets supply caps for multiple assets on AAVE V3 Polygon
 * - Snapshot: TBD //TODO
 * - Dicussion: https://governance.aave.com/t/arc-v3-borrow-cap-recommendations-fast-track-01-05-2022/10927
 */
contract AaveV3PolBorrowCapsPayload is IProposalGenericExecutor {
  address public constant LINK = 0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39;
  address public constant WBTC = 0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6;
  address public constant WETH = 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619;
  address public constant BAL = 0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3;
  address public constant CRV = 0x172370d5Cd63279eFa6d502DAB29171933a610AF;
  address public constant DPI = 0x85955046DF4668e1DD369D2DE9f3AEB98DD2A369;
  address public constant GHST = 0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7;

  uint256 public constant LINK_CAP = 163_702;
  uint256 public constant WBTC_CAP = 851;
  uint256 public constant WETH_CAP = 14_795;
  uint256 public constant BAL_CAP = 156_530;
  uint256 public constant CRV_CAP = 640_437;
  uint256 public constant DPI_CAP = 779;
  uint256 public constant GHST_CAP = 3_234_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Polygon.POOL_CONFIGURATOR;

    configurator.setBorrowCap(LINK, LINK_CAP);

    configurator.setBorrowCap(WBTC, WBTC_CAP);

    configurator.setBorrowCap(WETH, WETH_CAP);

    configurator.setBorrowCap(BAL, BAL_CAP);

    configurator.setBorrowCap(CRV, CRV_CAP);

    configurator.setBorrowCap(DPI, DPI_CAP);

    configurator.setBorrowCap(GHST, GHST_CAP);
  }
}
