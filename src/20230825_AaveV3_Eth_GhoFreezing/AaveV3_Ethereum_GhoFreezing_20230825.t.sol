// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'lib/aave-address-book/src/AaveV3Ethereum.sol';
import {AaveV3_Ethereum_GhoFreezing_20230825} from 'src/20230825_AaveV3_Eth_GhoFreezing/AaveV3_Ethereum_GhoFreezing_20230825.sol';
import {FreezingSteward} from './FreezingSteward.sol';

/**
 * @dev Test for AaveV3_Ethereum_GhoFreezing_20230825
 * command: make test-contract filter=AaveV3_Ethereum_GhoFreezing_20230825
 */
contract AaveV3_Ethereum_GhoFreezing_20230825_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_GhoFreezing_20230825 public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17988315);
  }

  function testPayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestAaveV3_Ethereum_GhoFreezing_20230825',
      AaveV3Ethereum.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3_Ethereum_GhoFreezing_20230825(
      0x2eE68ACb6A1319de1b49DC139894644E424fefD6
    );

    // 3. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestAaveV3_Ethereum_GhoFreezing_20230825',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'preTestAaveV3_Ethereum_GhoFreezing_20230825',
      'postTestAaveV3_Ethereum_GhoFreezing_20230825'
    );

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    e2eTest(AaveV3Ethereum.POOL);

    // Test of FreezeSteward

    vm.startPrank(0xCA76Ebd8617a03126B6FB84F9b1c1A0fB71C2633);

    FreezingSteward(proposalPayload.GUARDIAN_FREEZER()).setFreeze(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      false
    );

    ReserveConfig[] memory allConfigsAfter2 = createConfigurationSnapshot(
      'postStewardTestAaveV3_Ethereum_GhoFreezing_20230825',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'postTestAaveV3_Ethereum_GhoFreezing_20230825',
      'postStewardTestAaveV3_Ethereum_GhoFreezing_20230825'
    );

    vm.stopPrank();

    e2eTest(AaveV3Ethereum.POOL);
  }
}
