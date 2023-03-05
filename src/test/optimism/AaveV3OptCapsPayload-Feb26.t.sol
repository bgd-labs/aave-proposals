// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
import {AaveV3OptCapsPayload, AaveV3OptimismAssets} from '../../contracts/optimism/AaveV3OptCapsPayload-Feb26.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';


contract AaveV3OptCaps_Feb26PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3OptCapsPayload public proposalPayload;

  address public constant DAI = AaveV3OptimismAssets.DAI_UNDERLYING;
  address public constant SUSD = AaveV3OptimismAssets.sUSD_UNDERLYING;
  address public constant USDC = AaveV3OptimismAssets.USDC_UNDERLYING;
  address public constant USDT = AaveV3OptimismAssets.USDT_UNDERLYING;
  address public constant AAVE = AaveV3OptimismAssets.AAVE_UNDERLYING;
  address public constant LINK = AaveV3OptimismAssets.LINK_UNDERLYING;
  address public constant WBTC = AaveV3OptimismAssets.WBTC_UNDERLYING;

  uint256 public constant DAI_SUPPLY_CAP = 25_000_000;
  uint256 public constant DAI_BORROW_CAP = 16_000_000;
  
  uint256 public constant SUSD_BORROW_CAP = 13_000_000;

  uint256 public constant USDC_SUPPLY_CAP = 150_000_000;
  uint256 public constant USDC_BORROW_CAP = 100_000_000;

  uint256 public constant USDT_SUPPLY_CAP = 25_000_000;
  uint256 public constant USDT_BORROW_CAP = 16_000_000;

  uint256 public constant AAVE_SUPPLY_CAP = 45_000;

  uint256 public constant LINK_SUPPLY_CAP = 160_000;
  uint256 public constant LINK_BORROW_CAP = 84_000;

  uint256 public constant WBTC_SUPPLY_CAP = 620;
  uint256 public constant WBTC_BORROW_CAP = 250;


  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 44920020);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testCapsOpt() public {

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Optimism.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3OptCapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    // 5. verify results
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Optimism.POOL);

    //DAI
    ReserveConfig memory DAIConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, DAI);
    DAIConfig.supplyCap = DAI_SUPPLY_CAP;
    DAIConfig.borrowCap = DAI_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(DAIConfig, allConfigsAfter);

    //SUSD
    ReserveConfig memory SUSDConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, SUSD);
    SUSDConfig.borrowCap = SUSD_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(SUSDConfig, allConfigsAfter);

    //USDC
    ReserveConfig memory USDCConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, USDC);
    USDCConfig.supplyCap = USDC_SUPPLY_CAP;
    USDCConfig.borrowCap = USDC_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(USDCConfig, allConfigsAfter);

    //USDT
    ReserveConfig memory USDTConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, USDT);
    USDTConfig.supplyCap = USDT_SUPPLY_CAP;
    USDTConfig.borrowCap = USDT_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(USDTConfig, allConfigsAfter);

    //AAVE
    ReserveConfig memory AAVEConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, AAVE);
    AAVEConfig.supplyCap = AAVE_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(AAVEConfig, allConfigsAfter);

    //LINK
    ReserveConfig memory LINKConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, LINK);
    LINKConfig.supplyCap = LINK_SUPPLY_CAP;
    LINKConfig.borrowCap = LINK_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(LINKConfig, allConfigsAfter);

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, WBTC);
    WBTCConfig.supplyCap = WBTC_SUPPLY_CAP;
    WBTCConfig.borrowCap = WBTC_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);
  }
}
