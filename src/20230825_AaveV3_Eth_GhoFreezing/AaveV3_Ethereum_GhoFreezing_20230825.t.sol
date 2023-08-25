// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'lib/aave-address-book/src/AaveV3Ethereum.sol';
import {AaveV3_Ethereum_GhoFreezing_20230825} from 'src/20230825_AaveV3_Eth_GhoFreezing/AaveV3_Ethereum_GhoFreezing_20230825.sol';

/**
 * @dev Test for AaveV3_Ethereum_GhoFreezing_20230825
 * command: make test-contract filter=AaveV3_Ethereum_GhoFreezing_20230825
 */
contract AaveV3_Ethereum_GhoFreezing_20230825_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_GhoFreezing_20230825 public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17988010);
  }

  function testPayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestAaveV3_Ethereum_GhoFreezing_20230825',
      AaveV3Ethereum.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3_Ethereum_GhoFreezing_20230825(address(0)); // TODO add helper

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
  }
}
