// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3RiskParams_20230516} from 'src/AaveV3RiskParams_20230516/AaveV3RiskParams_20230516.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3RiskParams_20230516_Test is ProtocolV3TestBase, TestWithExecutor {
  uint256 public constant AAVE_UNDERLYING_LTV = 66_00; // 66.0%
  uint256 public constant AAVE_UNDERLYING_LIQ_THRESHOLD = 73_00; // 73.0%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17056559);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPayload() public {
    AaveV3RiskParams_20230516 proposalPayload = new AaveV3RiskParams_20230516();

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Ethereum.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3RiskParams_20230516Change', AaveV3Ethereum.POOL);

    // 2. execute payload
    _executePayload(address(proposalPayload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot('postAaveV3RiskParams_20230516Change', AaveV3Ethereum.POOL);

    // 4. Verify payload:
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Ethereum.POOL);

    ReserveConfig memory AAVE_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.AAVE_UNDERLYING
    );

    AAVE_UNDERLYING_CONFIG.liquidationThreshold = AAVE_UNDERLYING_LIQ_THRESHOLD;

    AAVE_UNDERLYING_CONFIG.ltv = AAVE_UNDERLYING_LTV;

    ProtocolV3TestBase._validateReserveConfig(AAVE_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV3RiskParams_20230516Change', 'postAaveV3RiskParams_20230516Change');
  }
}
