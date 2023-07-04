// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthFEIRiskParams_20230703} from './AaveV2EthFEIRiskParams_20230703.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

contract AaveV2EthFEIRiskParams_20230703_Test is ProtocolV2TestBase {
  uint256 public constant FEI_LTV = 0; // 0%
  uint256 public constant FEI_LIQUIDATION_THRESHOLD = 1_00; // 1%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17618386);
  }

  function testPayload() public {
    AaveV2EthFEIRiskParams_20230703 proposalPayload = new AaveV2EthFEIRiskParams_20230703();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2EthFEIRiskParams_20230703Change',
      AaveV2Ethereum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2EthFEIRiskParams_20230703Change',
      AaveV2Ethereum.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory FEI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.FEI_UNDERLYING
    );

    FEI_UNDERLYING_CONFIG.liquidationThreshold = FEI_LIQUIDATION_THRESHOLD;

    FEI_UNDERLYING_CONFIG.ltv = FEI_LTV;

    _validateReserveConfig(FEI_UNDERLYING_CONFIG, allConfigsAfter);

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV2EthereumAssets.FEI_UNDERLYING
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV2EthFEIRiskParams_20230703Change',
      'postAaveV2EthFEIRiskParams_20230703Change'
    );

    // 6. E2E Test
    address user = vm.addr(3);
    e2eTest(AaveV2Ethereum.POOL, user);
  }
}
