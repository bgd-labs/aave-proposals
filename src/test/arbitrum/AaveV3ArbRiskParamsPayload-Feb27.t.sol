// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Arbitrum} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbRiskParamsPayload} from '../../contracts/arbitrum/AaveV3ArbRiskParamsPayload-Feb27.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ArbRiskParamsTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3ArbRiskParamsPayload public proposalPayload;

  address public constant WETH = AaveV3ArbitrumAssets.WETH_UNDERLYING;
  address public constant WBTC = AaveV3ArbitrumAssets.WBTC_UNDERLYING;
  address public constant DAI = AaveV3ArbitrumAssets.DAI_UNDERLYING;
  address public constant USDC = AaveV3ArbitrumAssets.USDC_UNDERLYING;

  uint256 public constant WETH_LT = 8500; // 85%
  uint256 public constant WETH_LTV = 8250; // 82.5%

  uint256 public constant WBTC_LT = 7800; // 78%
  uint256 public constant WBTC_LTV = 7300; // 73%
  uint256 public constant WBTC_LIQ_BONUS = 10700; //10% -> 7% 

  uint256 public constant DAI_LT = 8200; // 82%
  uint256 public constant DAI_LTV = 7700; // 77%

  uint256 public constant USDC_LT = 8600; // 86%
  uint256 public constant USDC_LTV = 8100; // 81%


  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 65105087);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testRiskParamsArb() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Arbitrum.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3ArbRiskParamsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Arbitrum.POOL
    );

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, WETH);
    WETHConfig.liquidationThreshold = WETH_LT;
    WETHConfig.ltv = WETH_LTV;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, WBTC);
    WBTCConfig.liquidationThreshold = WBTC_LT;
    WBTCConfig.ltv = WBTC_LTV;
    WBTCConfig.liquidationBonus = WBTC_LIQ_BONUS;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);

    //DAI
    ReserveConfig memory DAIConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, DAI);
    DAIConfig.liquidationThreshold = DAI_LT;
    DAIConfig.ltv = DAI_LTV;
    ProtocolV3TestBase._validateReserveConfig(DAIConfig, allConfigsAfter);

    //USDC
    ReserveConfig memory USDCConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, USDC);
    USDCConfig.liquidationThreshold = USDC_LT;
    USDCConfig.ltv = USDC_LTV;
    ProtocolV3TestBase._validateReserveConfig(USDCConfig, allConfigsAfter);

  }
}