// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Eth_TUSDRateUpdate_20230808} from './AaveV2_Eth_TUSDRateUpdate_20230808.sol';

/**
 * @dev Test for AaveV2_Eth_TUSDRateUpdate_20230808
 * command: make test-contract filter=AaveV2_Eth_TUSDRateUpdate_20230808
 */
contract AaveV2_Eth_TUSDRateUpdate_20230808_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17871073);
  }

  function testProposalExecution() public {
    AaveV2_Eth_TUSDRateUpdate_20230808 proposal = new AaveV2_Eth_TUSDRateUpdate_20230808();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2_Eth_TUSDRateUpdate_20230808',
      AaveV2Ethereum.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2_Eth_TUSDRateUpdate_20230808',
      AaveV2Ethereum.POOL
    );

    diffReports('preAaveV2_Eth_TUSDRateUpdate_20230808', 'postAaveV2_Eth_TUSDRateUpdate_20230808');
  }
}