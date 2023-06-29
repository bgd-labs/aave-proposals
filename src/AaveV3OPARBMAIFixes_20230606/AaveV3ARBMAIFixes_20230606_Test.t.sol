// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3ARBMAIFixes_20230606} from './AaveV3ARBMAIFixes_20230606.sol';
import 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3ArbUpdate_20230327_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 98298854);
  }

  function testFail() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestArbMaiFixJun06',
      AaveV3Arbitrum.POOL
    );
    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigsBefore, AaveV3ArbitrumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigsBefore, AaveV3ArbitrumAssets.MAI_UNDERLYING)
    );
  }

  function testNewChanges() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestArbMaiFixJun06',
      AaveV3Arbitrum.POOL
    );

    _findReserveConfig(allConfigsBefore, AaveV3ArbitrumAssets.MAI_UNDERLYING);

    GovHelpers.executePayload(
      vm,
      address(new AaveV3ARBMAIFixes_20230606()),
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestArbMaiFixJun06',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory maiAfter = _findReserveConfig(
      allConfigsAfter,
      AaveV3ArbitrumAssets.MAI_UNDERLYING
    );

    diffReports('preTestArbMaiFixJun06', 'postTestArbMaiFixJun06');

    assertEq(maiAfter.isFlashloanable, true);

    _validateReserveTokensImpls(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      maiAfter,
      ReserveTokens({
        aToken: AaveV3Arbitrum.DEFAULT_A_TOKEN_IMPL_REV_2,
        stableDebtToken: AaveV3Arbitrum.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_2,
        variableDebtToken: AaveV3Arbitrum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2
      })
    );

    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3ArbitrumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3ArbitrumAssets.MAI_UNDERLYING)
    );
  }
}
