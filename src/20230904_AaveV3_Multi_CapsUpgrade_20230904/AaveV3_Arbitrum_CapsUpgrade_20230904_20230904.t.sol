// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Arbitrum_CapsUpgrade_20230904_20230904} from './AaveV3_Arbitrum_CapsUpgrade_20230904_20230904.sol';

/**
 * @dev Test for AaveV3_Arbitrum_CapsUpgrade_20230904_20230904
 * command: make test-contract filter=AaveV3_Arbitrum_CapsUpgrade_20230904_20230904
 */
contract AaveV3_Arbitrum_CapsUpgrade_20230904_20230904_Test is ProtocolV3TestBase {
  AaveV3_Arbitrum_CapsUpgrade_20230904_20230904 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 127957002);
    proposal = new AaveV3_Arbitrum_CapsUpgrade_20230904_20230904();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Arbitrum_CapsUpgrade_20230904_20230904',
      AaveV3Arbitrum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Arbitrum_CapsUpgrade_20230904_20230904',
      AaveV3Arbitrum.POOL
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3ArbitrumAssets.AAVE_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory AAVE = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.AAVE_UNDERLYING
    );
    AAVE.supplyCap = 2_710;
    _validateReserveConfig(AAVE, allConfigsAfter);

     e2eTestAsset(
        AaveV3Arbitrum.POOL,
        _findReserveConfig(allConfigsAfter, AaveV3ArbitrumAssets.WETH_UNDERLYING),
        _findReserveConfig(allConfigsAfter, AaveV3ArbitrumAssets.AAVE_UNDERLYING)
        );

    diffReports(
      'preAaveV3_Arbitrum_CapsUpgrade_20230904_20230904',
      'postAaveV3_Arbitrum_CapsUpgrade_20230904_20230904'
    );
  }
}
