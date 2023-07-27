// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';

import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {AaveV2_Eth_ServiceProviders_20231907} from './AaveV2_Eth_ServiceProviders_20231907.sol';
import {COWSwapper} from './COWSwapper20230726.sol';

contract AaveV2_Eth_ServiceProviders_20231907_Test is Test {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17778611);
  }

  function test_execute() public {
    AaveV2_Eth_ServiceProviders_20231907 payload = new AaveV2_Eth_ServiceProviders_20231907();

    uint256 balanceBeforeAUSDC = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 balanceBeforeUSDC = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertGt(
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      0
    );

    uint256 balanceBeforeAUSDT = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeADAI = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      0
    );

    assertEq(IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(payload)), 0);

    assertEq(IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(payload)), 0);

    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceBeforeAUSDC + balanceBeforeUSDC,
      200e6
    );

    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceBeforeAUSDT - payload.AMOUNT_USDT(),
      1
    );

    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceBeforeADAI - payload.AMOUNT_DAI(),
      1
    );
  }

  function test_swapperevertsIf_invalidCaller() public {
    COWSwapper swapper = new COWSwapper();

    vm.expectRevert(COWSwapper.InvalidCaller.selector);
    swapper.swap();
  }

  function test_cannotCancelTrade_invalidCaller() public {
    COWSwapper swapper = new COWSwapper();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).transfer(address(swapper), 1_000e6);
    vm.stopPrank();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).transfer(address(swapper), 1_000e18);
    vm.stopPrank();

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    swapper.swap();
    vm.stopPrank();

    vm.expectRevert(COWSwapper.InvalidCaller.selector);
    swapper.cancelSwap(address(0), address(0));
  }

  function test_cancelTrade_successful_allowedCaller() public {
    COWSwapper swapper = new COWSwapper();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).transfer(address(swapper), 1_000e6);
    vm.stopPrank();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).transfer(address(swapper), 1_000e18);
    vm.stopPrank();

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    swapper.swap();
    vm.stopPrank();

    vm.prank(swapper.ALLOWED_CALLER());
    swapper.cancelSwap(
      0xd5e77e96702694039D6E269cC116cc308806f48A, // These are created when running tests and emitted via log
      0xd0B587b7712a495499d45F761e234839d7E8D026 // Addresses were retrieved from there
    );
  }

  function test_cancelTrade_successful_governanceCaller() public {
    COWSwapper swapper = new COWSwapper();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).transfer(address(swapper), 1_000e6);
    vm.stopPrank();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).transfer(address(swapper), 1_000e18);
    vm.stopPrank();

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    swapper.swap();
    vm.stopPrank();

    vm.prank(AaveGovernanceV2.SHORT_EXECUTOR);
    swapper.cancelSwap(
      0xd5e77e96702694039D6E269cC116cc308806f48A, // These are created when running tests and emitted via log
      0xd0B587b7712a495499d45F761e234839d7E8D026 // Addresses were retrieved from there
    );
  }

  function test_SendEthToCOWSwapper() public {
    address ethWale = 0xF977814e90dA44bFA03b6295A0616a897441aceC;
    // Testing that you can't send ETH to the contract directly since there's no fallback() or receive() function
    vm.startPrank(ethWale);
    (bool success, ) = address(new COWSwapper()).call{value: 1 ether}('');
    assertTrue(!success);
  }

  function test_RescueTokens_allowedCaller() public {
    COWSwapper swapper = new COWSwapper();

    assertEq(IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(swapper)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(swapper)), 0);

    uint256 ausdtAmount = 1_000e6;
    uint256 adaiAmount = 1_000e18;

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).transfer(address(swapper), ausdtAmount);
    vm.stopPrank();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).transfer(address(swapper), adaiAmount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(swapper)), ausdtAmount);
    assertEq(IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(swapper)), adaiAmount);

    uint256 initialCollectorBalBalance = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 initialCollectorUsdcBalance = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    address[] memory tokens = new address[](2);
    tokens[0] = AaveV2EthereumAssets.USDT_A_TOKEN;
    tokens[1] = AaveV2EthereumAssets.DAI_A_TOKEN;
    vm.startPrank(swapper.ALLOWED_CALLER());
    swapper.rescueTokens(tokens);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorBalBalance + ausdtAmount
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorUsdcBalance + adaiAmount
    );
    assertEq(IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(swapper)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(swapper)), 0);
  }

  function test_RescueTokens_governanceCaller() public {
    address AAVE_WHALE = 0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8;
    address BAL_WHALE = 0xF977814e90dA44bFA03b6295A0616a897441aceC;

    COWSwapper swapper = new COWSwapper();

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(swapper)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(swapper)), 0);

    uint256 balAmount = 1_000e18;
    uint256 aaveAmount = 1_000e18;

    vm.startPrank(BAL_WHALE);
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).transfer(address(swapper), balAmount);
    vm.stopPrank();

    vm.startPrank(AAVE_WHALE);
    IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).transfer(address(swapper), aaveAmount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(swapper)), balAmount);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(swapper)), aaveAmount);

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
    swapper.rescueTokens(tokens);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorBalBalance + balAmount
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorUsdcBalance + aaveAmount
    );
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(swapper)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(swapper)), 0);
  }

  function test_RescueTokens_revertsIfInvalidCaller() public {
    address AAVE_WHALE = 0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8;

    COWSwapper swapper = new COWSwapper();

    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(swapper)), 0);

    uint256 aaveAmount = 1_000e18;

    vm.startPrank(AAVE_WHALE);
    IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).transfer(address(swapper), aaveAmount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(address(swapper)), aaveAmount);

    address[] memory tokens = new address[](1);
    tokens[0] = AaveV2EthereumAssets.AAVE_UNDERLYING;

    vm.expectRevert(COWSwapper.InvalidCaller.selector);
    swapper.rescueTokens(tokens);
  }
}
