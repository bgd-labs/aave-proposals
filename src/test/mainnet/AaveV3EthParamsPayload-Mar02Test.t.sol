// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthParamsPayload} from '../../contracts/mainnet/AaveV3EthParamsPayload-Mar02.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3EthParamsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3EthParamsPayload public proposalPayload;

  address public constant USDC = AaveV3EthereumAssets.USDC_UNDERLYING;
  address public constant DAI = AaveV3EthereumAssets.DAI_UNDERLYING;


  uint256 public constant USDC_LT = 7900; // 79%
  uint256 public constant USDC_LTV = 7700; // 77%

  uint256 public constant DAI_LT = 8000; // 80%
  uint256 public constant DAI_LTV = 6700; // 67%


  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16719526);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testParamsEth() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Ethereum.POOL);

    // 1. create payload
    proposalPayload = new AaveV3EthParamsPayload();

    // 2. execute l2 payload

    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Ethereum.POOL
    );

    // USDC
    ReserveConfig memory USDCConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, USDC);
    USDCConfig.liquidationThreshold = USDC_LT;
    USDCConfig.ltv = USDC_LTV;
    ProtocolV3TestBase._validateReserveConfig(USDCConfig, allConfigsAfter);

    // DAI
    ReserveConfig memory DAIConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, DAI);
    DAIConfig.liquidationThreshold = DAI_LT;
    DAIConfig.ltv = DAI_LTV;
    ProtocolV3TestBase._validateReserveConfig(DAIConfig, allConfigsAfter);

  }
}