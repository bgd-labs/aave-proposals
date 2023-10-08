// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008} from './AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008.sol';

/**
 * @dev Test for AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008
 * command: make test-contract filter=AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008
 */
contract AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18308021);
    proposal = new AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'preAaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008',
      'postAaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008'
    );

    e2eTest(AaveV3Ethereum.POOL);
  }
}
