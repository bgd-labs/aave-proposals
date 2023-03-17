// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolSTMATICCapPayload} from '../../contracts/polygon/AaveV3PolSTMATICCapPayload-Mar17.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolSTMATICCapPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolSTMATICCapPayload public proposalPayload;

  uint256 public constant STMATIC_SUPPLY_CAP = 21_000_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 40452868);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testCapsPol() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    //stMATIC
    ReserveConfig memory STMATICConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.stMATIC_UNDERLYING
    );
    STMATICConfig.supplyCap = STMATIC_SUPPLY_CAP;

    // 1. deploy l2 payload
    proposalPayload = new AaveV3PolSTMATICCapPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Polygon.POOL);

    _validateReserveConfig(STMATICConfig, allConfigsAfter);
  }
}
