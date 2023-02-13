// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolCapsPayload} from '../../contracts/polygon/AaveV3PolCapsPayload-Feb12.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolFeb12CapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolCapsPayload public proposalPayload;

  address public constant BAL = AaveV3PolygonAssets.BAL_UNDERLYING;
  address public constant EURS = AaveV3PolygonAssets.EURS_UNDERLYING;
  address public constant DAI = AaveV3PolygonAssets.DAI_UNDERLYING;
  address public constant USDC = AaveV3PolygonAssets.USDC_UNDERLYING;
  address public constant USDT = AaveV3PolygonAssets.USDT_UNDERLYING;

  uint256 public constant BAL_SUPPLY_CAP = 361_000;

  uint256 public constant EURS_BORROW_CAP = 947_000;

  uint256 public constant DAI_BORROW_CAP = 30_000_000;
  uint256 public constant DAI_SUPPLY_CAP = 45_000_000;

  uint256 public constant USDC_BORROW_CAP = 100_000_000;
  uint256 public constant USDC_SUPPLY_CAP = 150_000_000;

  uint256 public constant USDT_BORROW_CAP = 30_000_000;
  uint256 public constant USDT_SUPPLY_CAP = 45_000_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 39206488);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testPoolActivation() public {
    proposalPayload = new AaveV3PolCapsPayload();

    createConfigurationSnapshot('pre-poly12', AaveV3Polygon.POOL);

    _executePayload(address(proposalPayload));

    createConfigurationSnapshot('post-poly12', AaveV3Polygon.POOL);

    diffReports('pre-poly12', 'post-poly12');
  }

  function testBorrowCapsPol() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3PolCapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Polygon.POOL
    );

    ReserveConfig memory BalConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, BAL);
    BalConfig.supplyCap = BAL_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(BalConfig, allConfigsAfter);

    ReserveConfig memory EursConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, EURS);
    EursConfig.borrowCap = EURS_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(EursConfig, allConfigsAfter);

    ReserveConfig memory DaiConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, DAI);
    DaiConfig.borrowCap = DAI_BORROW_CAP;
    DaiConfig.supplyCap = DAI_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(DaiConfig, allConfigsAfter);

    ReserveConfig memory UsdcConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, USDC);
    UsdcConfig.borrowCap = USDC_BORROW_CAP;
    UsdcConfig.supplyCap = USDC_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(UsdcConfig, allConfigsAfter);

    ReserveConfig memory UsdtConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, USDT);
    UsdtConfig.borrowCap = USDT_BORROW_CAP;
    UsdtConfig.supplyCap = USDT_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(UsdtConfig, allConfigsAfter);
  }
}
