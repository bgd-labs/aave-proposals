// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3OPMAIFixes_20230606} from './AaveV3OPMAIFixes_20230606.sol';
import 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3OpUpdate_20230327_Test is ProtocolV3_0_1TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 105088970);

    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testFail() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestArbMaiFixJun06',
      AaveV3Optimism.POOL
    );
    e2eTestAsset(
      AaveV3Optimism.POOL,
      _findReserveConfig(allConfigsBefore, AaveV3OptimismAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigsBefore, AaveV3OptimismAssets.MAI_UNDERLYING)
    );
  }

  function testNewChanges() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestOpMaiFixJun06',
      AaveV3Optimism.POOL
    );

    _findReserveConfig(allConfigsBefore, AaveV3OptimismAssets.MAI_UNDERLYING);

    _executePayload(address(new AaveV3OPMAIFixes_20230606()));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestOpMaiFixJun06',
      AaveV3Optimism.POOL
    );

    ReserveConfig memory maiAfter = _findReserveConfig(
      allConfigsAfter,
      AaveV3OptimismAssets.MAI_UNDERLYING
    );

    diffReports('preTestOpMaiFixJun06', 'postTestOpMaiFixJun06');

    assertEq(maiAfter.isFlashloanable, true);

    _validateReserveTokensImpls(
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
      maiAfter,
      ReserveTokens({
        aToken: AaveV3Optimism.DEFAULT_A_TOKEN_IMPL_REV_2,
        stableDebtToken: AaveV3Optimism.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_2,
        variableDebtToken: AaveV3Optimism.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2
      })
    );

    e2eTestAsset(
      AaveV3Optimism.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3OptimismAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3OptimismAssets.MAI_UNDERLYING)
    );
  }
}
