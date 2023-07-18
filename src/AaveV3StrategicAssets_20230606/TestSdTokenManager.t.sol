// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {ISdDepositor} from './interfaces/ISdDepositor.sol';
import {StrategicAssetsManager} from './StrategicAssetsManager.sol';
import {SdTokenManager} from './SdTokenManager.sol';
import {Core} from './Core.sol';

contract SdTokenManagerTest is Test {
  address public constant CRV = 0xD533a949740bb3306d119CC777fa900bA034cd52;
  address public constant SD_CRV = 0xD1b5651E55D4CeeD36251c61c50C889B36F6abB5;
  address public constant CRV_VOTING = 0xBCfF8B0b9419b9A88c44546519b1e909cF330399;
  address public constant SD_CRV_DEPOSITOR = 0xc1e3Ca8A3921719bE0aE3690A0e036feB4f69191;

  uint256 public constant LOCK_DURATION_ONE_YEAR = 365 * 86400;
  uint256 public constant WEEK = 7 * 86400;

  address public immutable initialDelegate = makeAddr('initial-delegate');

  StrategicAssetsManager public strategicAssets;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17523941);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets = new StrategicAssetsManager();
    vm.stopPrank();
  }

  function _addSdToken(
    address underlying,
    address veToken,
    address depositor
  ) internal {
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addSdToken(underlying, veToken, depositor);
    vm.stopPrank();
  }
}

contract LockTestSdToken is SdTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.lock(CRV, 100e18);
  }

  function test_successful() public {
    _addSdToken(CRV, SD_CRV, SD_CRV_DEPOSITOR);

    address gaugeAddress = ISdDepositor(SD_CRV_DEPOSITOR).gauge();
    uint256 initialAmount = 1_000e18;
    uint256 deposited = 500e18;
    deal(CRV, address(strategicAssets), initialAmount);

    assertEq(IERC20(SD_CRV).balanceOf(address(strategicAssets)), 0);
    assertEq(IERC20(CRV).balanceOf(address(strategicAssets)), initialAmount);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(CRV, deposited);
    vm.stopPrank();

    assertGe(IERC20(gaugeAddress).balanceOf(address(strategicAssets)), deposited);
    assertEq(IERC20(CRV).balanceOf(address(strategicAssets)), initialAmount - deposited);
  }
}
