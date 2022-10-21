// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {MockExecutor} from './MockExecutor.sol';

abstract contract BaseTest is Test {
  MockExecutor internal _aclAdmin;

  function _setUp(address aclAdmin) internal {
    MockExecutor mockExecutor = new MockExecutor();
    vm.etch(aclAdmin, address(mockExecutor).code);
    _aclAdmin = MockExecutor(aclAdmin);
  }
}
