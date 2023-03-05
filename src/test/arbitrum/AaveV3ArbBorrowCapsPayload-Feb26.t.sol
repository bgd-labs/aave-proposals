// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Arbitrum} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbCapsPayload} from '../../contracts/arbitrum/AaveV3ArbBorrowCapsPayload-Feb26.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ArbFeb26CapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3ArbCapsPayload public proposalPayload;

  address public constant DAI = AaveV3ArbitrumAssets.DAI_UNDERLYING;
  address public constant EURS = AaveV3ArbitrumAssets.EURS_UNDERLYING;
  address public constant USDC = AaveV3ArbitrumAssets.USDC_UNDERLYING;
  address public constant USDT = AaveV3ArbitrumAssets.USDT_UNDERLYING;
  address public constant AAVE = AaveV3ArbitrumAssets.AAVE_UNDERLYING;

  uint256 public constant DAI_SUPPLY_CAP = 50_000_000;
  uint256 public constant DAI_BORROW_CAP = 30_000_000;

  uint256 public constant EURS_SUPPLY_CAP = 60_000;
  uint256 public constant EURS_BORROW_CAP = 45_000;

  uint256 public constant USDC_SUPPLY_CAP = 150_000_000;
  uint256 public constant USDC_BORROW_CAP = 100_000_000;

  uint256 public constant USDT_SUPPLY_CAP = 50_000_000;
  uint256 public constant USDT_BORROW_CAP = 35_000_000;

  uint256 public constant AAVE_SUPPLY_CAP = 1_850;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 64802596);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }


  function testCapsArb() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Arbitrum.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3ArbCapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Arbitrum.POOL
    );

    //DAI
    ReserveConfig memory DAIConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, DAI);
    DAIConfig.supplyCap = DAI_SUPPLY_CAP;
    DAIConfig.borrowCap = DAI_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(DAIConfig, allConfigsAfter);

    //EURS
    ReserveConfig memory EURSConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, EURS);
    EURSConfig.supplyCap = EURS_SUPPLY_CAP;
    EURSConfig.borrowCap = EURS_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(EURSConfig, allConfigsAfter);

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
  }
}
