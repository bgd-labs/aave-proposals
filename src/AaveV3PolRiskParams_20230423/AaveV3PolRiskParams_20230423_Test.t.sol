// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PolRiskParams_20230423} from './AaveV3PolRiskParams_20230423.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3PolRiskParams_20230423_Test is ProtocolV3TestBase, TestWithExecutor {
  uint256 public constant WBTC_UNDERLYING_LIQ_THRESHOLD = 78_00;
  uint256 public constant WBTC_UNDERLYING_LTV = 73_00;

  uint256 public constant DAI_UNDERLYING_LIQ_THRESHOLD = 81_00;
  uint256 public constant DAI_UNDERLYING_LTV = 76_00; 

  uint256 public constant LINK_UNDERLYING_LIQ_THRESHOLD = 68_00;
  uint256 public constant LINK_UNDERLYING_LTV = 53_00; 
  
  uint256 public constant WMATIC_UNDERLYING_LIQ_THRESHOLD = 73_00;
  uint256 public constant WMATIC_UNDERLYING_LTV = 68_00;
  uint256 public constant WMATIC_UNDERLYING_BONUS = 10700;


  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 42021187);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testPayload() public {
    AaveV3PolRiskParams_20230423 proposalPayload = new AaveV3PolRiskParams_20230423();

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3PolRiskParams_20230423Change', AaveV3Polygon.POOL);

    // 2. execute payload
    _executePayload(address(proposalPayload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot('postAaveV3PolRiskParams_20230423Change', AaveV3Polygon.POOL);

    // 4. Verify payload:
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Polygon.POOL);

    // WBTC
    ReserveConfig memory WBTC_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.WBTC_UNDERLYING
    );

    WBTC_UNDERLYING_CONFIG.liquidationThreshold = WBTC_UNDERLYING_LIQ_THRESHOLD;
    WBTC_UNDERLYING_CONFIG.ltv = WBTC_UNDERLYING_LTV;

    ProtocolV3TestBase._validateReserveConfig(WBTC_UNDERLYING_CONFIG, allConfigsAfter);

    // DAI
    ReserveConfig memory DAI_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.DAI_UNDERLYING
    );

    DAI_UNDERLYING_CONFIG.liquidationThreshold = DAI_UNDERLYING_LIQ_THRESHOLD;
    DAI_UNDERLYING_CONFIG.ltv = DAI_UNDERLYING_LTV;


    // LINK
    ReserveConfig memory LINK_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.LINK_UNDERLYING
    );

    LINK_UNDERLYING_CONFIG.liquidationThreshold = LINK_UNDERLYING_LIQ_THRESHOLD;
    LINK_UNDERLYING_CONFIG.ltv = LINK_UNDERLYING_LTV;

    ProtocolV3TestBase._validateReserveConfig(LINK_UNDERLYING_CONFIG, allConfigsAfter);


    // WMATIC
    ReserveConfig memory WMATIC_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.WMATIC_UNDERLYING
    );

    WMATIC_UNDERLYING_CONFIG.liquidationThreshold = WMATIC_UNDERLYING_LIQ_THRESHOLD;
    WMATIC_UNDERLYING_CONFIG.ltv = WMATIC_UNDERLYING_LTV;
    WMATIC_UNDERLYING_CONFIG.liquidationBonus = WMATIC_UNDERLYING_BONUS;

    ProtocolV3TestBase._validateReserveConfig(WMATIC_UNDERLYING_CONFIG, allConfigsAfter);


    // 5. compare snapshots
    diffReports('preAaveV3PolRiskParams_20230423Change', 'postAaveV3PolRiskParams_20230423Change');
  }
}
