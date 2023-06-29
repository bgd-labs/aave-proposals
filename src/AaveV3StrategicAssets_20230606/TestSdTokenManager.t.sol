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

  uint256 public constant LOCK_DURATION_ONE_YEAR = 365 * 86400;
  uint256 public constant WEEK = 7 * 86400;

  address public immutable initialDelegate = makeAddr('initial-delegate');

  StrategicAssetsManager public strategicAssets;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17523941);

    strategicAssets = new StrategicAssetsManager();
    strategicAssets.initialize();
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

contract LockTest is SdTokenManagerTest {

}
