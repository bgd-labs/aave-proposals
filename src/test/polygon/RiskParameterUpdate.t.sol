// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV2Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {ProxyHelpers} from 'aave-helpers/ProxyHelpers.sol';
import {BaseTest} from '../utils/BaseTest.sol';

import {RiskParameterUpdate} from '../../contracts/polygon/RiskParameterUpdate.sol';

contract RiskParameterUpdateTest is BaseTest {
  RiskParameterUpdate internal _payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 34550201);
    _setUp(AaveV3Polygon.ACL_ADMIN);
    _payload = new RiskParameterUpdate();
  }

  function test_executeProposal() public {
    _aclAdmin.execute(address(_payload));
  }

  function test_tenderlyCli() public {
    vm.startPrank(AaveV3Polygon.ACL_ADMIN);
    AaveV3Polygon.ACL_MANAGER.addPoolAdmin(address(_payload));
    AaveV3Polygon.ACL_MANAGER.addRiskAdmin(address(_payload));
    vm.stopPrank();
    _payload.execute();
  }
}
