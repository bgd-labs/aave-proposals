// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
import {AaveV3OptRiskParmasPayload, AaveV3OptimismAssets} from '../../contracts/optimism/AaveV3OptRiskParamsPayload-Feb28.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';


contract AaveV3OptRiskParmasPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3OptRiskParmasPayload public proposalPayload;

  uint256 public constant WETH_LIQ_THRESHOLD = 8500; // 85%
  uint256 public constant WETH_LTV = 8250; // 82.5%

  uint256 public constant WBTC_LIQ_THRESHOLD = 7800; // 78%
  uint256 public constant WBTC_LTV = 7300; // 73%
  uint256 public constant WBTC_LIQ_BONUS = 10700; // 7%

  uint256 public constant DAI_LIQ_THRESHOLD = 8200; // 82%
  uint256 public constant DAI_LTV = 7700; // 77%

  uint256 public constant USDC_LIQ_THRESHOLD = 8600; // 865
  uint256 public constant USDC_LTV = 8100; // 81%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 44920020);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testRiskParamsOpt() public {

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Optimism.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3OptRiskParmasPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    // 5. verify results
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Optimism.POOL);

    //DAI
    ReserveConfig memory DAIConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, AaveV3OptimismAssets.DAI_UNDERLYING);
    DAIConfig.liquidationThreshold = DAI_LIQ_THRESHOLD;
    DAIConfig.ltv = DAI_LTV;
    ProtocolV3TestBase._validateReserveConfig(DAIConfig, allConfigsAfter);


    //USDC
    ReserveConfig memory USDCConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, AaveV3OptimismAssets.USDC_UNDERLYING);
    USDCConfig.liquidationThreshold = USDC_LIQ_THRESHOLD;
    USDCConfig.ltv = USDC_LTV;
    ProtocolV3TestBase._validateReserveConfig(USDCConfig, allConfigsAfter);

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, AaveV3OptimismAssets.WBTC_UNDERLYING);
    WBTCConfig.liquidationThreshold = WBTC_LIQ_THRESHOLD;
    WBTCConfig.ltv = WBTC_LTV;
    WBTCConfig.liquidationBonus = WBTC_LIQ_BONUS;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, AaveV3OptimismAssets.WETH_UNDERLYING);
    WETHConfig.liquidationThreshold = WETH_LIQ_THRESHOLD;
    WETHConfig.ltv = WETH_LTV;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);
  }
}
