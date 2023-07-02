// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3POLSupplyBorrowUpdate_20230427} from './AaveV3POLSupplyBorrowUpdate_20230427.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract AaveV3POLSupplyBorrowUpdate_20230427Test is ProtocolV3LegacyTestBase {
  AaveV3POLSupplyBorrowUpdate_20230427 public proposalPayload;

  uint256 public constant WBTC_SUPPLY_CAP = 3_100;

  uint256 public constant LINK_SUPPLY_CAP = 370_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 42014159);
  }

  function testSupplyCapsEth() public {
    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3POLSupplyBorrowUpdate_20230427Change',
      AaveV3Polygon.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3POLSupplyBorrowUpdate_20230427();

    // 3. execute payload

    GovHelpers.executePayload(
      vm,
      address(proposalPayload),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    // 4. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3POLSupplyBorrowUpdate_20230427Change',
      AaveV3Polygon.POOL
    );

    //Verify payload:
    //WBTC
    ReserveConfig memory WBTCConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.WBTC_UNDERLYING
    );
    WBTCConfig.supplyCap = WBTC_SUPPLY_CAP;
    _validateReserveConfig(WBTCConfig, allConfigsAfter);

    //LINK
    ReserveConfig memory LINKConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.LINK_UNDERLYING
    );
    LINKConfig.supplyCap = LINK_SUPPLY_CAP;
    _validateReserveConfig(LINKConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3POLSupplyBorrowUpdate_20230427Change',
      'postAaveV3POLSupplyBorrowUpdate_20230427Change'
    );
  }
}
