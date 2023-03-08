// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GHSTV3RiskParamPayload} from '../../contracts/polygon/GHSTV3PolRiskParamPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract GHSTV3RiskParamPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  GHSTV3RiskParamPayload public proposalPayload;

  address public constant GHST = AaveV3PolygonAssets.GHST_UNDERLYING;
  uint256 public constant GHST_SUPPLY_CAP = 4_650_000;
  uint256 public constant GHST_BORROW_CAP = 220_000;
  uint256 public constant GHST_LTV = 0;
  uint256 public constant GHST_LIQ_THRESHOLD = 4500;
  uint256 public constant GHST_LIQ_BONUS = 11500;
  bool public constant GHST_BORROWING_ENABLED = false;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 40083492);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testBorrowCapsPol() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preParamChange', AaveV3Polygon.POOL);

    // 2. create payload
    proposalPayload = new GHSTV3RiskParamPayload();

    // 3. execute l2 payload

    _executePayload(address(proposalPayload));

    // 4. create snapshot after payload execution
    createConfigurationSnapshot('postParamChange', AaveV3Polygon.POOL);

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Polygon.POOL
    );

    //GHST
    ReserveConfig memory GHSTConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, GHST);
    GHSTConfig.borrowCap = GHST_BORROW_CAP;
    GHSTConfig.supplyCap = GHST_SUPPLY_CAP;
    GHSTConfig.borrowingEnabled = GHST_BORROWING_ENABLED;
    GHSTConfig.liquidationThreshold = GHST_LIQ_THRESHOLD;
    GHSTConfig.liquidationBonus = GHST_LIQ_BONUS;

    ProtocolV3TestBase._validateReserveConfig(GHSTConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preParamChange', 'postParamChange');
  }
}
