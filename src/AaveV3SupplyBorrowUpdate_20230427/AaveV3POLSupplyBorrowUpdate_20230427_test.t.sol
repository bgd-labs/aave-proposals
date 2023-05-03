// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3POLSupplyBorrowUpdate_20230427} from './AaveV3POLSupplyBorrowUpdate_20230427.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3POLSupplyBorrowUpdate_20230427Test is ProtocolV3TestBase, TestWithExecutor {
  AaveV3POLSupplyBorrowUpdate_20230427 public proposalPayload;

  uint256 public constant WBTC_SUPPLY_CAP = 3_100;

  uint256 public constant LINK_SUPPLY_CAP = 370_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 42014159);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testSupplyCapsEth() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot(
      'preAaveV3POLSupplyBorrowUpdate_20230427Change',
      AaveV3Polygon.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3POLSupplyBorrowUpdate_20230427();

    // 3. execute payload

    _executePayload(address(proposalPayload));

    // 4. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3POLSupplyBorrowUpdate_20230427Change',
      AaveV3Polygon.POOL
    );

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Polygon.POOL
    );

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.WBTC_UNDERLYING
    );
    WBTCConfig.supplyCap = WBTC_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);


    //LINK
    ReserveConfig memory LINKConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.LINK_UNDERLYING
    );
    LINKConfig.supplyCap = LINK_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(LINKConfig, allConfigsAfter);


    // 5. compare snapshots
    diffReports(
      'preAaveV3POLSupplyBorrowUpdate_20230427Change',
      'postAaveV3POLSupplyBorrowUpdate_20230427Change'
    );
  }
}
