// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2FreezeReserves_20230627} from './AaveV2FreezeReserves_20230627.sol';

contract AaveV2FreezeReserves_20230627Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17572985);
  }

  function testFreeze() public {
    ReserveConfig[] memory configsBefore = createConfigurationSnapshot(
      'pre-TUSD-freeze-v2',
      AaveV2Ethereum.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV2FreezeReserves_20230627()),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    ReserveConfig[] memory configsAfter = createConfigurationSnapshot(
      'post-TUSD-freeze-v2',
      AaveV2Ethereum.POOL
    );

    assertEq(_findReserveConfig(configsAfter, AaveV2EthereumAssets.TUSD_UNDERLYING).isFrozen, true);
    _noReservesConfigsChangesApartFrom(
      configsBefore,
      configsAfter,
      AaveV2EthereumAssets.TUSD_UNDERLYING
    );

    diffReports('pre-TUSD-freeze-v2', 'post-TUSD-freeze-v2');
  }
}
