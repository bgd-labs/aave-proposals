// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Optimism_OPRiskParametersUpdate_20230924} from './AaveV3_Optimism_OPRiskParametersUpdate_20230924.sol';

/**
 * @dev Test for AaveV3_Optimism_OPRiskParametersUpdate_20230924
 * command: make test-contract filter=AaveV3_Optimism_OPRiskParametersUpdate_20230924
 */
contract AaveV3_Optimism_OPRiskParametersUpdate_20230924_Test is ProtocolV3TestBase {
  AaveV3_Optimism_OPRiskParametersUpdate_20230924 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 109974433);
    proposal = new AaveV3_Optimism_OPRiskParametersUpdate_20230924();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Optimism_OPRiskParametersUpdate_20230924',
      AaveV3Optimism.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Optimism_OPRiskParametersUpdate_20230924',
      AaveV3Optimism.POOL
    );

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3OptimismAssets.OP_UNDERLYING
    );

    e2eTestAsset(
      AaveV3Optimism.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3OptimismAssets.WETH_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3OptimismAssets.OP_UNDERLYING)
    );

    diffReports(
      'preAaveV3_Optimism_OPRiskParametersUpdate_20230924',
      'postAaveV3_Optimism_OPRiskParametersUpdate_20230924'
    );
  }
}
