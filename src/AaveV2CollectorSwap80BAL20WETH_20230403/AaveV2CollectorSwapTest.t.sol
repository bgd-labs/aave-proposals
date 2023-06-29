// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {console2} from 'forge-std/Test.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {SwapFor80BAL20WETHPayload} from './AaveV2CollectorSwap80BAL20WETH_20230403_Payload.sol';
import {COWTrader} from './COWTrader.sol';

contract SwapFor80BAL20WETHPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  event TradeCanceled();
  event TradeRequested();

  SwapFor80BAL20WETHPayload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17175879);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    payload = new SwapFor80BAL20WETHPayload();
  }

  function test_execute_tradeSuccessful() public {
    uint256 balanceABalBefore = IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceAEthBalBefore = IERC20(AaveV3EthereumAssets.BAL_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceBalBefore = IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceWethBefore = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceAWethBefore = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertEq(balanceABalBefore, 9644860562923757165584);
    assertEq(balanceAEthBalBefore, 24678874950526891803);
    assertEq(balanceBalBefore, 300_000e18);
    assertEq(balanceWethBefore, 10312312833722949345);
    assertEq(balanceAWethBefore, 1516828016650101081302);

    vm.expectEmit(true, true, true, true);
    emit TradeRequested();

    _executePayload(address(payload));

    uint256 balanceABalAfter = IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceAEthBalAfter = IERC20(AaveV3EthereumAssets.BAL_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceBalAfter = IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceWethAfter = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceAWethAfter = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertEq(balanceABalAfter, 19081042984225183256);
    assertEq(balanceAEthBalAfter, 0);
    assertEq(balanceBalAfter, 0);
    assertEq(balanceWethAfter, balanceWethBefore);

    // Withdraw is not an exact science so within 0.1 wETH
    assertApproxEqAbs(balanceAWethAfter, balanceAWethBefore - payload.WETH_AMOUNT(), 1e17);
  }

  function test_tradeRevertsIf_invalidCaller() public {
    COWTrader trader = new COWTrader();

    vm.expectRevert(COWTrader.InvalidCaller.selector);
    trader.trade();
  }

  function test_cannotTradeTwice() public {
    COWTrader trader = new COWTrader();
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    trader.trade();
    vm.stopPrank();

    vm.expectRevert(COWTrader.PendingTrade.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    trader.trade();
    vm.stopPrank();
  }

  function test_cannotCancelTrade_ifNonePending() public {
    COWTrader trader = new COWTrader();

    vm.expectRevert(COWTrader.NoPendingTrade.selector);
    trader.cancelTrades(address(0), address(0));
  }

  function test_cannotCancelTrade_invalidCaller() public {
    COWTrader trader = new COWTrader();

    address BAL_WHALE = 0xF977814e90dA44bFA03b6295A0616a897441aceC;
    vm.startPrank(BAL_WHALE);
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).transfer(address(trader), 1_000e18);
    vm.stopPrank();

    address WETH_WHALE = 0xeD1840223484483C0cb050E6fC344d1eBF0778a9;
    vm.startPrank(WETH_WHALE);
    IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).transfer(address(trader), 1_000e18);
    vm.stopPrank();

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    trader.trade();
    vm.stopPrank();

    vm.expectRevert(COWTrader.InvalidCaller.selector);
    trader.cancelTrades(address(0), address(0));
  }

  function test_cancelTrade_successful_allowedCaller() public {
    COWTrader trader = new COWTrader();

    address BAL_WHALE = 0xF977814e90dA44bFA03b6295A0616a897441aceC;
    vm.startPrank(BAL_WHALE);
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).transfer(address(trader), 1_000e18);
    vm.stopPrank();

    address WETH_WHALE = 0xeD1840223484483C0cb050E6fC344d1eBF0778a9;
    vm.startPrank(WETH_WHALE);
    IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).transfer(address(trader), 1_000e18);
    vm.stopPrank();

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    trader.trade();
    vm.stopPrank();

    vm.expectEmit(true, true, true, true);
    emit TradeCanceled();

    vm.prank(trader.ALLOWED_CALLER());
    trader.cancelTrades(
      0xafD72023254Fb9118B9bcCe8E302aEBA1e554276,
      0xAC720F35F3e60D3E9e6FB6F4047EE6dB7D16cA23
    );
  }

  function test_cancelTrade_successful_governanceCaller() public {
    COWTrader trader = new COWTrader();

    address BAL_WHALE = 0xF977814e90dA44bFA03b6295A0616a897441aceC;
    vm.startPrank(BAL_WHALE);
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).transfer(address(trader), 1_000e18);
    vm.stopPrank();

    address WETH_WHALE = 0xeD1840223484483C0cb050E6fC344d1eBF0778a9;
    vm.startPrank(WETH_WHALE);
    IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).transfer(address(trader), 1_000e18);
    vm.stopPrank();

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    trader.trade();
    vm.stopPrank();

    vm.expectEmit(true, true, true, true);
    emit TradeCanceled();

    vm.prank(AaveGovernanceV2.SHORT_EXECUTOR);
    trader.cancelTrades(
      0xafD72023254Fb9118B9bcCe8E302aEBA1e554276,
      0xAC720F35F3e60D3E9e6FB6F4047EE6dB7D16cA23
    );
  }

  function test_SendEthToCOWTrader() public {
    address ethWale = 0xF977814e90dA44bFA03b6295A0616a897441aceC;
    // Testing that you can't send ETH to the contract directly since there's no fallback() or receive() function
    vm.startPrank(ethWale);
    (bool success, ) = address(new COWTrader()).call{value: 1 ether}('');
    assertTrue(!success);
  }

  function test_RescueTokens_allowedCaller() public {
    address AAVE_WHALE = 0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8;
    address BAL_WHALE = 0xF977814e90dA44bFA03b6295A0616a897441aceC;

    COWTrader trader = new COWTrader();

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(trader)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), 0);

    uint256 balAmount = 1_000e18;
    uint256 aaveAmount = 1_000e18;

    vm.startPrank(BAL_WHALE);
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).transfer(address(trader), balAmount);
    vm.stopPrank();

    vm.startPrank(AAVE_WHALE);
    IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).transfer(address(trader), aaveAmount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(trader)), balAmount);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), aaveAmount);

    uint256 initialCollectorBalBalance = IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 initialCollectorUsdcBalance = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    address[] memory tokens = new address[](2);
    tokens[0] = AaveV2EthereumAssets.BAL_UNDERLYING;
    tokens[1] = AaveV2EthereumAssets.AAVE_UNDERLYING;
    vm.startPrank(trader.ALLOWED_CALLER());
    trader.rescueTokens(tokens);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorBalBalance + balAmount
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorUsdcBalance + aaveAmount
    );
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), 0);
  }

  function test_RescueTokens_governanceCaller() public {
    address AAVE_WHALE = 0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8;
    address BAL_WHALE = 0xF977814e90dA44bFA03b6295A0616a897441aceC;

    COWTrader trader = new COWTrader();

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(trader)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), 0);

    uint256 balAmount = 1_000e18;
    uint256 aaveAmount = 1_000e18;

    vm.startPrank(BAL_WHALE);
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).transfer(address(trader), balAmount);
    vm.stopPrank();

    vm.startPrank(AAVE_WHALE);
    IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).transfer(address(trader), aaveAmount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(trader)), balAmount);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), aaveAmount);

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
    trader.rescueTokens(tokens);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorBalBalance + balAmount
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorUsdcBalance + aaveAmount
    );
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), 0);
  }

  function test_RescueTokens_revertsIfInvalidCaller() public {
    address AAVE_WHALE = 0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8;

    COWTrader trader = new COWTrader();

    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), 0);

    uint256 aaveAmount = 1_000e18;

    vm.startPrank(AAVE_WHALE);
    IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).transfer(address(trader), aaveAmount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(trader)), aaveAmount);

    address[] memory tokens = new address[](1);
    tokens[0] = AaveV2EthereumAssets.AAVE_UNDERLYING;

    vm.expectRevert(COWTrader.InvalidCaller.selector);
    trader.rescueTokens(tokens);
  }
}
