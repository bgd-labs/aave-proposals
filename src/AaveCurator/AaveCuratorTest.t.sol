// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';
import {AaveCurator} from './AaveCurator.sol';

contract AaveCuratorTest is Test {
  AaveCurator private trader = new AaveCurator();

  function setUp() public {}
}

contract AaveTreasuryManagementTrade is AaveCuratorTest {}

contract ClaimParaswapFees is AaveCuratorTest {}

contract CancelTrade is AaveCuratorTest {}

contract DepositIntoAave is AaveCuratorTest {}
