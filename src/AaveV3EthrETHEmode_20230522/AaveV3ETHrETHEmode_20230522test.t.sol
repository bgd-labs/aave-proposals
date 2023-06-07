// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ETHrETHEmode_20230522} from 'src/AaveV3EthrETHEmode_20230522/AaveV3ETHrETHEmode_20230522.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3ETHrETHEmode_20230522_Test is ProtocolV3TestBase, TestWithExecutor {
  uint256 public constant AAVE_EMODE_CATEGORY = 1; 

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17314034);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPayload() public {
    AaveV3ETHrETHEmode_20230522 proposalPayload = new AaveV3ETHrETHEmode_20230522();

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Ethereum.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3ETHrETHEmode_20230522Change', AaveV3Ethereum.POOL);

    // 2. execute payload
    _executePayload(address(proposalPayload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot('postAaveV3ETHrETHEmode_20230522Change', AaveV3Ethereum.POOL);

    // 4. Verify payload:
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Ethereum.POOL);

    ReserveConfig memory rETH_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.rETH_UNDERLYING
    );

    rETH_UNDERLYING_CONFIG.eModeCategory = AAVE_EMODE_CATEGORY;

    ProtocolV3TestBase._validateReserveConfig(rETH_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV3ETHrETHEmode_20230522Change', 'postAaveV3ETHrETHEmode_20230522Change');
  }
}
