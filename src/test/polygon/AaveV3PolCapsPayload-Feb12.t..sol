// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolCapsPayload} from '../../contracts/polygon/AaveV3PolCapsPayload-Feb12.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolFeb12CapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolCapsPayload public proposalPayload;

  address public constant BAL = 0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3;
  address public constant EURS = 0xE111178A87A3BFf0c8d18DECBa5798827539Ae99;
  address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
  address public constant USDC = 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174;
  address public constant USDT = 0xc2132D05D31c914a87C6611C10748AEb04B58e8F;

  uint256 public constant BAL_SUPPLY_CAP = 361_000;
  uint256 public constant EURS_BORROW_CAP = 947_000;
  uint256 public constant DAI_BORROW_CAP = 30_000_000;
  uint256 public constant USDC_BORROW_CAP = 100_000_000;
  uint256 public constant USDT_BORROW_CAP = 30_000_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 39206488);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
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
    ProtocolV3TestBase._validateReserveConfig(DaiConfig, allConfigsAfter);

    ReserveConfig memory UsdcConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, USDC);
    UsdcConfig.borrowCap = USDC_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(UsdcConfig, allConfigsAfter);

    ReserveConfig memory UsdtConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, USDT);
    UsdtConfig.borrowCap = USDT_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(UsdtConfig, allConfigsAfter);
  }
}
