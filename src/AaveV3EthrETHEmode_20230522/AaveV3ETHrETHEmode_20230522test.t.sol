// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ETHrETHEmode_20230522} from 'src/AaveV3EthrETHEmode_20230522/AaveV3ETHrETHEmode_20230522.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3ETHrETHEmode_20230522_Test is ProtocolV3LegacyTestBase {
  uint256 public constant AAVE_EMODE_CATEGORY = 1;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17314034);
  }

  function testPayload() public {
    AaveV3ETHrETHEmode_20230522 proposalPayload = new AaveV3ETHrETHEmode_20230522();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3ETHrETHEmode_20230522Change',
      AaveV3Ethereum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3ETHrETHEmode_20230522Change',
      AaveV3Ethereum.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory rETH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.rETH_UNDERLYING
    );

    rETH_UNDERLYING_CONFIG.eModeCategory = AAVE_EMODE_CATEGORY;

    _validateReserveConfig(rETH_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV3ETHrETHEmode_20230522Change', 'postAaveV3ETHrETHEmode_20230522Change');
  }
}
