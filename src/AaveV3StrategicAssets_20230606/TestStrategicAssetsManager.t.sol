// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {StrategicAssetsManager} from './StrategicAssetsManager.sol';
import {VeTokenManager} from './VeTokenManager.sol';
import {Core} from './Core.sol';

contract StrategicAssetsManagerTest is Test {
  event SdTokenAdded(address indexed underlying, address sdToken);
  event SdTokenRemoved(address indexed underlying, address sdToken);
  event StrategicAssetsManagerChanged(address indexed oldManager, address indexed newManager);
  event VeTokenAdded(address indexed underlying, address veToken);
  event VeTokenRemoved(address indexed underlying, address veToken);
  event WithdrawalERC20(address indexed _token, address _to, uint256 _amount);

  // VeToken
  address public constant BALANCER_GAUGE_CONTROLLER = 0xC128468b7Ce63eA702C1f104D55A2566b13D3ABD;
  address public constant STAKE_DAO_GAUGE_CONTROLLER = 0x75f8f7fa4b6DA6De9F4fE972c811b778cefce882;
  address public constant B_80BAL_20WETH = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;
  address public constant VE_BAL = 0xC128a9954e6c874eA3d62ce62B468bA073093F25;
  address public constant WARDEN_VE_BAL = 0x42227bc7D65511a357c43993883c7cef53B25de9;
  bytes32 public constant BALANCER_SPACE_ID = 'balancer.eth';
  uint256 public constant LOCK_DURATION_ONE_YEAR = 365 * 86400;

  // SdToken
  address public constant CRV = 0xD533a949740bb3306d119CC777fa900bA034cd52;
  address public constant SD_CRV = 0xD1b5651E55D4CeeD36251c61c50C889B36F6abB5;
  address public constant SD_CRV_DEPOSITOR = 0xc1e3Ca8A3921719bE0aE3690A0e036feB4f69191;

  address public immutable initialDelegate = makeAddr('initial-delegate');

  StrategicAssetsManager public strategicAssets;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17523941);

    strategicAssets = new StrategicAssetsManager();
    strategicAssets.initialize();
  }
}

contract Initialize is StrategicAssetsManagerTest {
  function test_revertsIf_alreadyInitialized() public {
    vm.expectRevert('Contract instance has already been initialized');
    strategicAssets.initialize();
  }
}

contract AddVeTokens is StrategicAssetsManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.addVeToken(
      B_80BAL_20WETH,
      VE_BAL,
      WARDEN_VE_BAL,
      LOCK_DURATION_ONE_YEAR,
      initialDelegate,
      BALANCER_SPACE_ID
    );
  }

  function test_revertsIf_underlyingIsAddress0x() public {
    vm.expectRevert(Core.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addVeToken(
      address(0),
      VE_BAL,
      WARDEN_VE_BAL,
      LOCK_DURATION_ONE_YEAR,
      initialDelegate,
      BALANCER_SPACE_ID
    );
    vm.stopPrank();
  }

  function test_revertsIf_veTokenIsAddress0x() public {
    vm.expectRevert(Core.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addVeToken(
      B_80BAL_20WETH,
      address(0),
      WARDEN_VE_BAL,
      LOCK_DURATION_ONE_YEAR,
      initialDelegate,
      BALANCER_SPACE_ID
    );
    vm.stopPrank();
  }

  function test_successful() public {
    vm.expectEmit();
    emit VeTokenAdded(B_80BAL_20WETH, VE_BAL);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addVeToken(
      B_80BAL_20WETH,
      VE_BAL,
      WARDEN_VE_BAL,
      LOCK_DURATION_ONE_YEAR,
      initialDelegate,
      BALANCER_SPACE_ID
    );
    vm.stopPrank();

    (
      bytes32 spaceId,
      uint256 lockDuration,
      address veToken,
      address delegate,
      address warden
    ) = strategicAssets.veTokens(B_80BAL_20WETH);
    assertEq(spaceId, BALANCER_SPACE_ID);
    assertEq(lockDuration, LOCK_DURATION_ONE_YEAR);
    assertEq(veToken, VE_BAL);
    assertEq(delegate, initialDelegate);
    assertEq(warden, WARDEN_VE_BAL);
  }
}

contract RemoveVeTokens is StrategicAssetsManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.removeVeToken(B_80BAL_20WETH);
  }

  function test_successful() public {
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addVeToken(
      B_80BAL_20WETH,
      VE_BAL,
      WARDEN_VE_BAL,
      LOCK_DURATION_ONE_YEAR,
      initialDelegate,
      BALANCER_SPACE_ID
    );

    (
      bytes32 spaceId,
      uint256 lockDuration,
      address veToken,
      address delegate,
      address warden
    ) = strategicAssets.veTokens(B_80BAL_20WETH);
    assertEq(spaceId, BALANCER_SPACE_ID);
    assertEq(lockDuration, LOCK_DURATION_ONE_YEAR);
    assertEq(veToken, VE_BAL);
    assertEq(delegate, initialDelegate);
    assertEq(warden, WARDEN_VE_BAL);

    vm.expectEmit();
    emit VeTokenRemoved(B_80BAL_20WETH, VE_BAL);
    strategicAssets.removeVeToken(B_80BAL_20WETH);
    vm.stopPrank();

    (
      bytes32 spaceIdAfter,
      uint256 lockDurationAfter,
      address veTokenAfter,
      address delegateAfter,
      address wardenAfter
    ) = strategicAssets.veTokens(B_80BAL_20WETH);
    assertEq(spaceIdAfter, '');
    assertEq(lockDurationAfter, 0);
    assertEq(veTokenAfter, address(0));
    assertEq(delegateAfter, address(0));
    assertEq(wardenAfter, address(0));
  }
}

contract AddSdTokens is StrategicAssetsManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.addSdToken(CRV, SD_CRV, SD_CRV_DEPOSITOR);
  }

  function test_revertsIf_underlyingIsAddress0x() public {
    vm.expectRevert(Core.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addSdToken(address(0), SD_CRV, SD_CRV_DEPOSITOR);
    vm.stopPrank();
  }

  function test_revertsIf_veTokenIsAddress0x() public {
    vm.expectRevert(Core.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addSdToken(CRV, address(0), SD_CRV_DEPOSITOR);
    vm.stopPrank();
  }

  function test_successful() public {
    vm.expectEmit();
    emit SdTokenAdded(CRV, SD_CRV);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addSdToken(CRV, SD_CRV, SD_CRV_DEPOSITOR);
    vm.stopPrank();

    (address sdToken, address depositor) = strategicAssets.sdTokens(CRV);
    assertEq(sdToken, SD_CRV);
    assertEq(depositor, SD_CRV_DEPOSITOR);
  }
}

contract RemoveSdTokens is StrategicAssetsManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.removeSdToken(CRV);
  }

  function test_successful() public {
    vm.expectEmit();
    emit SdTokenAdded(CRV, SD_CRV);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addSdToken(CRV, SD_CRV, SD_CRV_DEPOSITOR);

    (address sdToken, address depositor) = strategicAssets.sdTokens(CRV);
    assertEq(sdToken, SD_CRV);
    assertEq(depositor, SD_CRV_DEPOSITOR);

    vm.expectEmit();
    emit SdTokenRemoved(CRV, SD_CRV);
    strategicAssets.removeSdToken(CRV);
    vm.stopPrank();

    (address sdTokenAfter, address depositorAfter) = strategicAssets.sdTokens(CRV);
    assertEq(sdTokenAfter, address(0));
    assertEq(depositorAfter, address(0));
  }
}

contract SetAdmin is StrategicAssetsManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.setAdmin(makeAddr('new-admin'));
  }

  function test_successful() public {
    address newAdmin = makeAddr('new-admin');
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setAdmin(newAdmin);
    vm.stopPrank();

    assertEq(newAdmin, strategicAssets.admin());
  }
}

contract SetStrategicAssetManager is StrategicAssetsManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.setStrategicAssetsManager(makeAddr('new-admin'));
  }

  function test_revertsIf_managerIs0xAddress() public {
    vm.expectRevert(Core.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setStrategicAssetsManager(address(0));
    vm.stopPrank();
  }

  function test_successful() public {
    address newManager = makeAddr('new-admin');
    vm.expectEmit();
    emit StrategicAssetsManagerChanged(strategicAssets.manager(), newManager);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setStrategicAssetsManager(newManager);
    vm.stopPrank();

    assertEq(newManager, strategicAssets.manager());
  }
}

contract RemoveStrategicAssetManager is StrategicAssetsManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.removeStrategicAssetManager();
  }

  function test_successful() public {
    vm.expectEmit();
    emit StrategicAssetsManagerChanged(strategicAssets.manager(), address(0));
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.removeStrategicAssetManager();
    vm.stopPrank();

    assertEq(address(0), strategicAssets.manager());
  }
}

contract WithdrawERC20 is StrategicAssetsManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(Core.InvalidCaller.selector);
    strategicAssets.withdrawERC20(B_80BAL_20WETH, address(AaveV2Ethereum.COLLECTOR), 1e18);
  }

  function test_revertsIf_insufficientBalance() public {
    vm.expectRevert('BAL#406');
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.withdrawERC20(B_80BAL_20WETH, address(AaveV2Ethereum.COLLECTOR), 1e18);
    vm.stopPrank();
  }

  function test_revertsIf_transferToZeroAddress() public {
    deal(B_80BAL_20WETH, address(strategicAssets), 10e18);
    vm.expectRevert(Core.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.withdrawERC20(B_80BAL_20WETH, address(0), 1e18);
    vm.stopPrank();
  }

  function test_successful() public {
    uint256 amount = 1e18;
    deal(B_80BAL_20WETH, address(strategicAssets), 10e18);
    uint256 balanceManagerBefore = IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets));
    uint256 balanceCollectorBefore = IERC20(B_80BAL_20WETH).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    vm.expectEmit();
    emit WithdrawalERC20(B_80BAL_20WETH, address(AaveV2Ethereum.COLLECTOR), amount);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.withdrawERC20(B_80BAL_20WETH, address(AaveV2Ethereum.COLLECTOR), amount);
    vm.stopPrank();

    uint256 balanceManagerAfter = IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets));
    uint256 balanceCollectorAfter = IERC20(B_80BAL_20WETH).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertEq(balanceManagerBefore - amount, balanceManagerAfter);
    assertEq(balanceCollectorBefore + amount, balanceCollectorAfter);
  }
}
