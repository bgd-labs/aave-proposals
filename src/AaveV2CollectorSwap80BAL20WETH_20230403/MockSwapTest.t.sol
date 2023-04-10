// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MockSwap} from './MockSwap.sol';

contract MockSwapTest is Test {
  MockSwap swap;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16991646);
    swap = new MockSwap();
  }

  function testSwap() public {
    vm.startPrank(0x2fb7d6bEb9AD75c1ffD392681cC68171B8551107);
    IERC20(swap.WETH()).transfer(address(swap), swap.amount());

    swap.swap();
    vm.stopPrank();
  }

  function testSwapExpectRevert() public {
    vm.expectRevert(MockSwap.SenderNotOwner.selector);
    swap.swap();
  }
}
