// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';

contract RiskParameterUpdate is IProposalGenericExecutor {
  address public constant GHST = 0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7;

  address public constant AAVE = 0xD6DF932A45C0f255f85145f286eA0b292B21C90B;

  address public constant BAL = 0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3;

  address public constant CRV = 0x172370d5Cd63279eFa6d502DAB29171933a610AF;

  address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;

  address public constant DPI = 0x85955046DF4668e1DD369D2DE9f3AEB98DD2A369;

  address public constant EURS = 0xE111178A87A3BFf0c8d18DECBa5798827539Ae99;

  address public constant LINK = 0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39;

  address public constant MAI = 0xa3Fa99A148fA48D14Ed51d610c367C61876997F1;

  address public constant WMATIC = 0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270;

  address public constant SUSHI = 0x0b3F868E0BE5597D5DB7fEB59E1CADBb0fdDa50a;

  address public constant USDC = 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174;

  address public constant USDT = 0xc2132D05D31c914a87C6611C10748AEb04B58e8F;

  address public constant WBTC = 0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6;

  address public constant WETH = 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619;

  function execute() external override {
    // polygon v2
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(GHST);
    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      GHST,
      2500,
      4000,
      11250
    );

    // polygon v3
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(AAVE, 36_820);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(BAL, 96_798);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(BAL, 284_600);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(CRV, 303_150);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(CRV, 937_700);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(DAI, 3_860_000);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(DPI, 218);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(DPI, 1_417);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(EURS, 728_520);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(GHST, 904_000);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(GHST, 5_876_000);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(LINK, 51_029);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(LINK, 297_640);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(MAI, 359_980);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(WMATIC, 9_225_000);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(WMATIC, 32_880_000);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(SUSHI, 102_484);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(SUSHI, 299_320);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(USDC, 30_680_000);

    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(USDT, 5_060_000);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(WBTC, 155);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(WBTC, 1_548);

    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(WETH, 2_690);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(WETH, 26_900);
  }
}
