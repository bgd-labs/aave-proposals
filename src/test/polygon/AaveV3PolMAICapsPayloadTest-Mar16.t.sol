// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolMAICapsPayload} from '../../contracts/polygon/AaveV3PolMAICapsPayload-Mar16.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolMAICapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolMAICapsPayload public proposalPayload;

  uint256 public constant MAI_SUPPLY_CAP = 2_200_000;
  uint256 public constant MAI_BORROW_CAP = 1_200_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 40422909);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testSupplyCapsPol() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    //MAI
    ReserveConfig memory MaiConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.miMATIC_UNDERLYING
    );
    MaiConfig.borrowCap = MAI_BORROW_CAP;
    MaiConfig.supplyCap = MAI_SUPPLY_CAP;

    // 1. deploy l2 payload
    proposalPayload = new AaveV3PolMAICapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Polygon.POOL
    );

    ProtocolV3TestBase._validateReserveConfig(MaiConfig, allConfigsAfter);
  }
}
