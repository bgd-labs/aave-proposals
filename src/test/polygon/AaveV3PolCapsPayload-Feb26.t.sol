// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolCapsPayload} from '../../contracts/polygon/AaveV3PolCapsPayload-Feb26.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolFeb12CapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolCapsPayload public proposalPayload;

  address public constant WETH = AaveV3PolygonAssets.WETH_UNDERLYING;
  address public constant AAVE = AaveV3PolygonAssets.AAVE_UNDERLYING;

  uint256 public constant WETH_SUPPLY_CAP = 50_000;
  uint256 public constant AAVE_SUPPLY_CAP = 70_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 39737420);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testCapsPol() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3PolCapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Polygon.POOL
    );

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, WETH);
    WETHConfig.supplyCap = WETH_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);

    //AAVE
    ReserveConfig memory AAVEConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, AAVE);
    AAVEConfig.supplyCap = AAVE_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(AAVEConfig, allConfigsAfter);
  }
}
