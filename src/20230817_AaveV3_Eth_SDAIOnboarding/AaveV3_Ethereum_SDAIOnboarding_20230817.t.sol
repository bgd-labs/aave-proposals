// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'lib/aave-helpers/src/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'lib/aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_SDAIOnboarding_20230817} from './AaveV3_Ethereum_SDAIOnboarding_20230817.sol';

/**
 * @dev Test for AaveV3_Ethereum_SDAIOnboarding_20230817
 * command: make test-contract filter=AaveV3_Ethereum_SDAIOnboarding_20230817
 */
contract AaveV3_Ethereum_SDAIOnboarding_20230817_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_SDAIOnboarding_20230817 internal proposal;
  address public constant SDAI = 0x83F20F44975D03b1b09e64809B757c47f942BEeA;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17971411);
    proposal = new AaveV3_Ethereum_SDAIOnboarding_20230817();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_SDAIOnboarding_20230817',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_SDAIOnboarding_20230817',
      AaveV3Ethereum.POOL
    );

    e2eTestAsset(
        AaveV3Ethereum.POOL,
        _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.DAI_UNDERLYING),
        _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.USDC_UNDERLYING)
        );

    e2eTestAsset(
        AaveV3Ethereum.POOL,
        _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.WETH_UNDERLYING),
        _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.USDC_UNDERLYING)
        );

    e2eTestAsset(
      AaveV3Ethereum.POOL,
        _findReserveConfig(allConfigsAfter, SDAI),
        _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.USDC_UNDERLYING)
        );
     
    diffReports(
      'preAaveV3_Ethereum_SDAIOnboarding_20230817',
      'postAaveV3_Ethereum_SDAIOnboarding_20230817'
    );
  }
}
