// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2FreezeReserves_20230619} from './AaveV2FreezeReserves_20230619.sol';

contract AaveV2FreezeReserves_20230619Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17535822);
  }

  function testFreeze() public {
    createConfigurationSnapshot('pre-freeze-v2', AaveV2Ethereum.POOL);

    GovHelpers.executePayload(
      vm,
      address(new AaveV2FreezeReserves_20230619()),
      AaveGovernanceV2.SHORT_EXECUTOR
    );
    createConfigurationSnapshot('post-freeze-v2', AaveV2Ethereum.POOL);

    diffReports('pre-freeze-v2', 'post-freeze-v2');
  }
}
