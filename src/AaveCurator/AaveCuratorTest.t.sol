// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {AaveCurator} from './AaveCurator.sol';

contract AaveCuratorTest is Test {
  event AdminChanged(address indexed oldAdmin, address indexed newAdmin);
  event DepositedIntoV2(address indexed token, uint256 amount);
  event DepositedIntoV3(address indexed token, uint256 amount);
  event ManagerChanged(address indexed oldAdmin, address indexed newAdmin);
  event SwapCanceled(address fromToken, address toToken, uint256 amount);
  event SwapRequested(address fromToken, address toToken, uint256 amount);
  event TokenUpdated(address indexed token, bool allowed);

  AaveCurator public curator;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17708493);

    curator = new AaveCurator();
    curator.initialize();
  }
}

contract Initialize is AaveCuratorTest {
  function test_revertsIf_alreadyInitialized() public {
    vm.expectRevert('Contract instance has already been initialized');
    curator.initialize();
  }
}

contract SetAdmin is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.setAdmin(makeAddr('new-admin'));
  }

  function test_successful() public {
    address newAdmin = makeAddr('new-admin');
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    vm.expectEmit();
    emit AdminChanged(AaveGovernanceV2.SHORT_EXECUTOR, newAdmin);
    curator.setAdmin(newAdmin);
    vm.stopPrank();

    assertEq(newAdmin, curator.admin());
  }
}

contract SetManager is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.setManager(makeAddr('new-admin'));
  }

  function test_revertsIf_managerIs0xAddress() public {
    vm.expectRevert(AaveCurator.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setManager(address(0));
    vm.stopPrank();
  }

  function test_successful() public {
    address newManager = makeAddr('new-admin');
    vm.expectEmit();
    emit ManagerChanged(curator.manager(), newManager);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setManager(newManager);
    vm.stopPrank();

    assertEq(newManager, curator.manager());
  }
}

contract RemoveManager is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.removeManager();
  }

  function test_successful() public {
    vm.expectEmit();
    emit ManagerChanged(curator.manager(), address(0));
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.removeManager();
    vm.stopPrank();

    assertEq(address(0), curator.manager());
  }
}

contract AaveCuratorSwap is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    uint256 amount = 1_000e18;
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.swap(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      amount,
      200,
      AaveCurator.TokenType.Standard
    );
  }

  function test_revertsIf_amountIsZero() public {
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    vm.expectRevert(AaveCurator.InvalidAmount.selector);
    curator.swap(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      0,
      200,
      AaveCurator.TokenType.Standard
    );
    vm.stopPrank();
  }

  function test_revertsIf_fromTokenNotAllowed() public {
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    vm.expectRevert(AaveCurator.InvalidToken.selector);
    curator.swap(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      1_000e18,
      200,
      AaveCurator.TokenType.Standard
    );
    vm.stopPrank();
  }

  function test_revertsIf_toTokenNotAllowed() public {
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedFromToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );
    vm.expectRevert(AaveCurator.InvalidToken.selector);
    curator.swap(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      1_000e18,
      200,
      AaveCurator.TokenType.Standard
    );
    vm.stopPrank();
  }

  function test_revertsIf_invalidRecipient() public {
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedFromToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );
    curator.setAllowedToToken(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDC_ORACLE,
      true,
      true
    );
    vm.expectRevert(AaveCurator.InvalidRecipient.selector);
    curator.swap(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      makeAddr('new-recipient'),
      1_000e18,
      200,
      AaveCurator.TokenType.Standard
    );
    vm.stopPrank();
  }

  function test_successful() public {
    deal(AaveV2EthereumAssets.AAVE_UNDERLYING, address(curator), 1_000e18);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedFromToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );
    curator.setAllowedToToken(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDC_ORACLE,
      true,
      true
    );

    vm.expectEmit(true, true, true, true);
    emit SwapRequested(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      1_000e18
    );
    curator.swap(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      1_000e18,
      200,
      AaveCurator.TokenType.Standard
    );
    vm.stopPrank();
  }
}

contract CancelSwap is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    uint256 amount = 1_000e18;
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.cancelSwap(
      makeAddr('milkman-instance'),
      AaveV2EthereumAssets.WETH_UNDERLYING,
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      amount,
      200,
      AaveCurator.TokenType.Standard
    );
  }

  function test_revertsIf_noMatchingTrade() public {
    deal(AaveV2EthereumAssets.AAVE_UNDERLYING, address(curator), 1_000e18);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedFromToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );
    curator.setAllowedToToken(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDC_ORACLE,
      true,
      true
    );

    curator.swap(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      1_000e18,
      200,
      AaveCurator.TokenType.Standard
    );

    vm.expectRevert();
    curator.cancelSwap(
      makeAddr('not-milkman-instance'),
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      1_000e18,
      200,
      AaveCurator.TokenType.Standard
    );
    vm.stopPrank();
  }

  function test_successful() public {
    deal(AaveV2EthereumAssets.AAVE_UNDERLYING, address(curator), 1_000e18);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedFromToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );
    curator.setAllowedToToken(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDC_ORACLE,
      true,
      true
    );

    vm.expectEmit(true, true, true, true);
    emit SwapRequested(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      1_000e18
    );
    curator.swap(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      1_000e18,
      200,
      AaveCurator.TokenType.Standard
    );

    vm.expectEmit();
    emit SwapCanceled(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      1_000e18
    );
    curator.cancelSwap(
      0x4C68Ef9151e03Ce92f97709B86247D9bCE16486e, // Address generated by tests
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      address(AaveV2Ethereum.COLLECTOR),
      1_000e18,
      200,
      AaveCurator.TokenType.Standard
    );
    vm.stopPrank();
  }
}

contract DepositIntoAaveV2 is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    uint256 amount = 1_000e18;
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.depositTokenIntoV2(AaveV2EthereumAssets.AAVE_UNDERLYING, amount);
  }

  function test_revertsIf_invalidToken() public {
    uint256 amount = 1_000e18;
    vm.expectRevert(AaveCurator.InvalidToken.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.depositTokenIntoV2(AaveV2EthereumAssets.AAVE_UNDERLYING, amount);
    vm.stopPrank();
  }

  function test_successful() public {
    uint256 amount = 1_000e18;

    deal(AaveV2EthereumAssets.AAVE_UNDERLYING, address(curator), amount);

    uint256 balanceCollectorBefore = IERC20(AaveV2EthereumAssets.AAVE_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), amount);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedFromToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );

    vm.expectEmit();
    emit DepositedIntoV2(AaveV2EthereumAssets.AAVE_UNDERLYING, amount);
    curator.depositTokenIntoV2(AaveV2EthereumAssets.AAVE_UNDERLYING, amount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), 0);
    assertGt(
      IERC20(AaveV2EthereumAssets.AAVE_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceCollectorBefore
    );
  }
}

contract DepositIntoAaveV3 is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    uint256 amount = 1_000e18;
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.depositTokenIntoV3(AaveV3EthereumAssets.AAVE_UNDERLYING, amount);
  }

  function test_revertsIf_invalidToken() public {
    uint256 amount = 1_000e18;
    vm.expectRevert(AaveCurator.InvalidToken.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.depositTokenIntoV3(AaveV3EthereumAssets.AAVE_UNDERLYING, amount);
    vm.stopPrank();
  }

  function test_successful() public {
    uint256 amount = 1_000e18;

    deal(AaveV3EthereumAssets.AAVE_UNDERLYING, address(curator), amount);

    uint256 balanceCollectorBefore = IERC20(AaveV3EthereumAssets.AAVE_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), amount);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedFromToken(
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveV3EthereumAssets.AAVE_ORACLE,
      true,
      true
    );

    vm.expectEmit();
    emit DepositedIntoV3(AaveV3EthereumAssets.AAVE_UNDERLYING, amount);
    curator.depositTokenIntoV3(AaveV3EthereumAssets.AAVE_UNDERLYING, amount);
    vm.stopPrank();

    assertEq(IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), 0);
    assertGt(
      IERC20(AaveV3EthereumAssets.AAVE_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceCollectorBefore
    );
  }
}

contract DepositWstEth is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    uint256 amount = 1_000e18;
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.depositWstETH(amount);
  }

  function test_successful() public {
    uint256 amount = 1_000e18;
    deal(AaveV2EthereumAssets.WETH_UNDERLYING, address(curator), 1_000e18);

    assertEq(IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(curator)), amount);
    assertEq(IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(address(curator)), 0);

    uint256 balanceCollectorBefore = IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.depositWstETH(amount);
    vm.stopPrank();

    assertGt(
      IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceCollectorBefore
    );
    assertEq(IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(curator)), 0);
    assertEq(IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(address(curator)), 0);
  }
}

contract DepositRETH is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    uint256 amount = 1_000e18;
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.depositRETH(amount);
  }

  function test_successful() public {
    uint256 amount = 1_000e18;
    deal(AaveV2EthereumAssets.WETH_UNDERLYING, address(curator), 1_000e18);

    assertEq(IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(curator)), amount);
    assertEq(IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(curator)), 0);

    uint256 balanceCollectorBefore = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.depositRETH(amount);
    vm.stopPrank();

    assertGt(
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceCollectorBefore
    );
    assertEq(IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(curator)), 0);
    assertEq(IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(curator)), 0);
  }
}

contract SetAllowedFromToken is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.setAllowedFromToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );
  }

  function test_revertsIf_fromTokenIsAddressZero() public {
    vm.expectRevert(AaveCurator.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedFromToken(address(0), AaveV2EthereumAssets.AAVE_ORACLE, true, true);
    vm.stopPrank();
  }

  function test_revertsIf_oracleIsAddressZero() public {
    vm.expectRevert(AaveCurator.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedFromToken(AaveV2EthereumAssets.AAVE_UNDERLYING, address(0), true, true);
    vm.stopPrank();
  }

  function test_successful() public {
    assertFalse(curator.allowedFromTokens(AaveV2EthereumAssets.AAVE_UNDERLYING));
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    vm.expectEmit();
    emit TokenUpdated(AaveV2EthereumAssets.AAVE_UNDERLYING, true);
    curator.setAllowedFromToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );
    vm.stopPrank();

    assertTrue(curator.allowedFromTokens(AaveV2EthereumAssets.AAVE_UNDERLYING));
  }
}

contract SetAllowedToToken is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.setAllowedToToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );
  }

  function test_revertsIf_fromTokenIsAddressZero() public {
    vm.expectRevert(AaveCurator.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedToToken(address(0), AaveV2EthereumAssets.AAVE_ORACLE, true, true);
    vm.stopPrank();
  }

  function test_revertsIf_oracleIsAddressZero() public {
    vm.expectRevert(AaveCurator.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setAllowedToToken(AaveV2EthereumAssets.AAVE_UNDERLYING, address(0), true, true);
    vm.stopPrank();
  }

  function test_successful() public {
    assertFalse(curator.allowedToTokens(AaveV2EthereumAssets.AAVE_UNDERLYING));
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    vm.expectEmit();
    emit TokenUpdated(AaveV2EthereumAssets.AAVE_UNDERLYING, true);
    curator.setAllowedToToken(
      AaveV2EthereumAssets.AAVE_UNDERLYING,
      AaveV2EthereumAssets.AAVE_ORACLE,
      true,
      true
    );
    vm.stopPrank();

    assertTrue(curator.allowedToTokens(AaveV2EthereumAssets.AAVE_UNDERLYING));
  }
}

contract WithdrawToCollector is AaveCuratorTest {
  function test_revertsIf_invalidCaller() public {
    address[] memory tokens = new address[](2);
    tokens[0] = AaveV2EthereumAssets.BAL_UNDERLYING;
    tokens[1] = AaveV2EthereumAssets.AAVE_UNDERLYING;

    vm.expectRevert(AaveCurator.InvalidCaller.selector);
    curator.withdrawToCollector(tokens);
  }

  function test_successful_allowedCaller() public {
    address AAVE_WHALE = 0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8;
    address BAL_WHALE = 0xF977814e90dA44bFA03b6295A0616a897441aceC;

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(curator)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), 0);

    uint256 balAmount = 1_000e18;
    uint256 aaveAmount = 1_000e18;

    vm.startPrank(BAL_WHALE);
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).transfer(address(curator), balAmount);
    vm.stopPrank();

    vm.startPrank(AAVE_WHALE);
    IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).transfer(address(curator), aaveAmount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(curator)), balAmount);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), aaveAmount);

    uint256 initialCollectorBalBalance = IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 initialCollectorUsdcBalance = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    address newManager = makeAddr('new-manager');
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.setManager(newManager);
    vm.stopPrank();

    address[] memory tokens = new address[](2);
    tokens[0] = AaveV2EthereumAssets.BAL_UNDERLYING;
    tokens[1] = AaveV2EthereumAssets.AAVE_UNDERLYING;
    vm.startPrank(newManager);
    curator.withdrawToCollector(tokens);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorBalBalance + balAmount
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorUsdcBalance + aaveAmount
    );
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), 0);
  }

  function test_successful_governanceCaller() public {
    address AAVE_WHALE = 0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8;
    address BAL_WHALE = 0xF977814e90dA44bFA03b6295A0616a897441aceC;

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(curator)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), 0);

    uint256 balAmount = 1_000e18;
    uint256 aaveAmount = 1_000e18;

    vm.startPrank(BAL_WHALE);
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).transfer(address(curator), balAmount);
    vm.stopPrank();

    vm.startPrank(AAVE_WHALE);
    IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).transfer(address(curator), aaveAmount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(curator)), balAmount);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), aaveAmount);

    uint256 initialCollectorBalBalance = IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 initialCollectorUsdcBalance = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    address[] memory tokens = new address[](2);
    tokens[0] = AaveV2EthereumAssets.BAL_UNDERLYING;
    tokens[1] = AaveV2EthereumAssets.AAVE_UNDERLYING;
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    curator.withdrawToCollector(tokens);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorBalBalance + balAmount
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorUsdcBalance + aaveAmount
    );
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(curator)), 0);
  }
}
