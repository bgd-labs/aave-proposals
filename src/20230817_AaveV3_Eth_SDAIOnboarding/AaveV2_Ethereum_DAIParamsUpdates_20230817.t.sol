// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2_Ethereum_DAIParamsUpdates_20230817} from 'src/20230817_AaveV3_Eth_SDAIOnboarding/AaveV2_Ethereum_DAIParamsUpdates_20230817.sol';

/**
 * @dev Test for AaveV3_Ethereum_SDAIOnboarding_20230817
 * command: make test-contract filter=AaveV2_Ethereum_DAIParamsUpdates_20230817
 */
contract AaveV2_Ethereum_DAIParamsUpdates_20230817_Test is ProtocolV2TestBase {
  AaveV2_Ethereum_DAIParamsUpdates_20230817 public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17971411);
  }

  function testPayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestAaveV2_Ethereum_DAIParamsUpdates_20230817',
      AaveV2Ethereum.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV2_Ethereum_DAIParamsUpdates_20230817();

    // 3. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestAaveV2_Ethereum_DAIParamsUpdates_20230817',
      AaveV2Ethereum.POOL
    );

    e2eTestAsset(
        AaveV2Ethereum.POOL,
        _findReserveConfig(allConfigsAfter, AaveV2EthereumAssets.DAI_UNDERLYING),
        _findReserveConfig(allConfigsAfter, AaveV2EthereumAssets.USDC_UNDERLYING)
        );

    diffReports(
      'preTestAaveV2_Ethereum_DAIParamsUpdates_20230817',
      'postTestAaveV2_Ethereum_DAIParamsUpdates_20230817'
    );

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, AaveV2EthereumAssets.DAI_UNDERLYING);
  }
}
