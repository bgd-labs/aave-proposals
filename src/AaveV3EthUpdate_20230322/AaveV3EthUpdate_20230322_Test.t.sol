// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthUpdate20230322Payload} from './AaveV3EthUpdate_20230322.sol';

contract AaveV3EthUpdate_20230322_Test is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16878259);

    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testNewChanges() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestEthCapsUpdateMar22',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory wstethBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.wstETH_UNDERLYING
    );

    ReserveConfig memory rethBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.rETH_UNDERLYING
    );

    _executePayload(address(new AaveV3EthUpdate20230322Payload()));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestEthCapsUpdateMar22',
      AaveV3Ethereum.POOL
    );

    diffReports('preTestEthCapsUpdateMar22', 'postTestEthCapsUpdateMar22');

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3EthereumAssets.wstETH_UNDERLYING;
    assetsChanged[1] = AaveV3EthereumAssets.rETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      wstethBefore.borrowCap = 6_000;
      _validateReserveConfig(wstethBefore, allConfigsAfter);
    }

    {
      rethBefore.borrowCap = 2_400;
      _validateReserveConfig(rethBefore, allConfigsAfter);
    }
  }
}
