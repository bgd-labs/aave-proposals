// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3RiskParams_20230516} from 'src/AaveV3RiskParams_20230516/AaveV3RiskParams_20230516.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3RiskParams_20230516_Test is ProtocolV3LegacyTestBase {
  uint256 public constant AAVE_UNDERLYING_LTV = 66_00; // 66.0%
  uint256 public constant AAVE_UNDERLYING_LIQ_THRESHOLD = 73_00; // 73.0%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17056559);
  }

  function testPayload() public {
    AaveV3RiskParams_20230516 proposalPayload = new AaveV3RiskParams_20230516();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3RiskParams_20230516Change',
      AaveV3Ethereum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3RiskParams_20230516Change',
      AaveV3Ethereum.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory AAVE_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.AAVE_UNDERLYING
    );

    AAVE_UNDERLYING_CONFIG.liquidationThreshold = AAVE_UNDERLYING_LIQ_THRESHOLD;

    AAVE_UNDERLYING_CONFIG.ltv = AAVE_UNDERLYING_LTV;

    _validateReserveConfig(AAVE_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV3RiskParams_20230516Change', 'postAaveV3RiskParams_20230516Change');
  }
}
