// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IPoolAddressesProvider} from 'aave-address-book/AaveV3.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';
import {MockExecutor} from './MockExecutor.sol';

abstract contract BaseTest is Test {
  MockExecutor internal _executor;

  function _setUp(address executor) internal {
    MockExecutor mockExecutor = new MockExecutor();
    vm.etch(executor, address(mockExecutor).code);

    _executor = MockExecutor(executor);
  }

  function _execute(address payload) internal {
    _executor.execute(payload);
  }
}
