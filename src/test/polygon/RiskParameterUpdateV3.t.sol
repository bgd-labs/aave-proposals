// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV2Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {BaseTest} from '../utils/BaseTest.sol';
import {RiskParameterUpdateV3} from '../../contracts/polygon/RiskParameterUpdateV3.sol';

contract RiskParameterUpdateV3Test is BaseTest, ProtocolV3TestBase {
  RiskParameterUpdateV3 internal _payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 34550201);
    _setUp(AaveV3Polygon.ACL_ADMIN);
    _payload = new RiskParameterUpdateV3();
  }

  function test_executeProposal() public {
    this.createConfigurationSnapshot('before', AaveV3Polygon.POOL);
    _aclAdmin.execute(address(_payload));
    this.createConfigurationSnapshot('after', AaveV3Polygon.POOL);
  }
}
