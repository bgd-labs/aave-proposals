// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolBorrowCapsPayload} from '../../contracts/polygon/AaveV3PolBorrowCapsPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolCapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolBorrowCapsPayload public proposalPayload;

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

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 36331342);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testBorrowCapsPol() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3PolBorrowCapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Polygon.POOL
    );

    //LINK
    ReserveConfig memory LinkConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, LINK);
    LinkConfig.borrowCap = LINK_CAP;
    ProtocolV3TestBase._validateReserveConfig(LinkConfig, allConfigsAfter);

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, WBTC);
    WBTCConfig.borrowCap = WBTC_CAP;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, WETH);
    WETHConfig.borrowCap = WETH_CAP;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);

    //BAL
    ReserveConfig memory BALConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, BAL);
    BALConfig.borrowCap = BAL_CAP;
    ProtocolV3TestBase._validateReserveConfig(BALConfig, allConfigsAfter);

    //CRV
    ReserveConfig memory CRVConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, CRV);
    CRVConfig.borrowCap = CRV_CAP;
    ProtocolV3TestBase._validateReserveConfig(CRVConfig, allConfigsAfter);

    //DPI
    ReserveConfig memory DPIConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, DPI);
    DPIConfig.borrowCap = DPI_CAP;
    ProtocolV3TestBase._validateReserveConfig(DPIConfig, allConfigsAfter);

    //GHST
    ReserveConfig memory GHSTConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, GHST);
    GHSTConfig.borrowCap = GHST_CAP;
    ProtocolV3TestBase._validateReserveConfig(GHSTConfig, allConfigsAfter);
  }
}
