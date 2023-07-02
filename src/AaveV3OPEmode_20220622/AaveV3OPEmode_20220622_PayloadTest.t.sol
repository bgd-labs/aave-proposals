// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3OPEmode_20220622_Payload} from './AaveV3OPEmode_20220622_Payload.sol';

contract AaveV3OPEmode_20220622_PayloadTest is ProtocolV3TestBase {
  AaveV3OPEmode_20220622_Payload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 105944795);
    payload = new AaveV3OPEmode_20220622_Payload();
  }

  function test_proposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-Aave-V3-Optimism-EMode-20220622',
      AaveV3Optimism.POOL
    );

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-Aave-V3-Optimism-EMode-20220622',
      AaveV3Optimism.POOL
    );

    ReserveConfig memory weth = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.WETH_UNDERLYING
    );
    ReserveConfig memory wsteth = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.wstETH_UNDERLYING
    );

    weth.eModeCategory = payload.EMODE_CATEGORY_ID_ETH_CORRELATED();
    wsteth.eModeCategory = payload.EMODE_CATEGORY_ID_ETH_CORRELATED();

    _validateReserveConfig(weth, allConfigsAfter);
    _validateReserveConfig(wsteth, allConfigsAfter);

    diffReports('pre-Aave-V3-Optimism-EMode-20220622', 'post-Aave-V3-Optimism-EMode-20220622');
  }
}
