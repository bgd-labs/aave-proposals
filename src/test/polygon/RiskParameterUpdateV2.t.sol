// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV2Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';
import {BaseTest} from '../utils/BaseTest.sol';

import {RiskParameterUpdateV2} from '../../contracts/polygon/RiskParameterUpdateV2.sol';

contract RiskParameterUpdateV2Test is BaseTest {
  RiskParameterUpdateV2 internal _payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 34550201);
    _setUp(AaveV3Polygon.ACL_ADMIN);
    _payload = new RiskParameterUpdateV2();
  }

  function test_executeProposal() public {
    _aclAdmin.execute(address(_payload));
  }
}
