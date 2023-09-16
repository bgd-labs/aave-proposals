// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

import {COWSwapper} from './COWSwapper20230801.sol';
import {TokenAddresses} from './TokenAddresses.sol';
import {AaveV2_Eth_TreasuryManagement_20230308} from './AaveV2_Eth_TreasuryManagement_20230308.sol';

/**
 * @dev Test for AaveV2_Eth_TreasuryManagement_20230308
 * command: make test-contract filter=AaveV2_Eth_TreasuryManagement_20230308
 */
contract AaveV2_Eth_TreasuryManagement_20230308_Test is ProtocolV2TestBase {
  using SafeERC20 for IERC20;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17865681);
  }

  function test_execute_twentythree() public {
    AaveV2_Eth_TreasuryManagement_20230308 payload = new AaveV2_Eth_TreasuryManagement_20230308();

    // Collector has tokens before payload
    TokenAddresses.TokenToWithdraw[] memory aTokens = TokenAddresses.getTokensToWithdraw();
    for (uint256 i = 0; i < aTokens.length; i++) {
      assertGt(IERC20(aTokens[i].aToken).balanceOf(address(AaveV2Ethereum.COLLECTOR)), 0);
    }

    uint256 balanceRWA = IERC20(payload.RWA_aUSDC()).balanceOf(address(AaveV2Ethereum.COLLECTOR));

    assertEq(IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)), 0);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    // All tokens removed from Collector for full balance
    TokenAddresses.TokenToSwap[] memory tokensAfter = TokenAddresses.getTokensToSwap();
    for (uint256 i = 0; i < tokensAfter.length; i++) {
      assertEq(IERC20(tokensAfter[i].token).balanceOf(address(AaveV2Ethereum.COLLECTOR)), 0);
    }

    assertLt(IERC20(payload.RWA_aUSDC()).balanceOf(address(AaveV2Ethereum.COLLECTOR)), balanceRWA);
  }

  function test_swappeRevertsIf_invalidCaller() public {
    COWSwapper swapper = new COWSwapper();

    vm.expectRevert(COWSwapper.InvalidCaller.selector);
    swapper.swap(AaveV2EthereumAssets.FRAX_UNDERLYING, AaveV2EthereumAssets.FRAX_ORACLE, 500);
  }

  function test_cannotCancelSwap_invalidCaller() public {
    COWSwapper swapper = new COWSwapper();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).transfer(address(swapper), 1_000e6);
    vm.stopPrank();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).transfer(address(swapper), 1_000e18);
    vm.stopPrank();

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    swapper.swap(AaveV2EthereumAssets.FRAX_UNDERLYING, AaveV2EthereumAssets.FRAX_ORACLE, 500);
    vm.stopPrank();

    vm.expectRevert(COWSwapper.InvalidCaller.selector);
    swapper.cancelSwap(
      address(0),
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV2EthereumAssets.FRAX_ORACLE,
      1,
      500
    );
  }

  function test_cancelSwap_successful_allowedCaller() public {
    COWSwapper swapper = new COWSwapper();

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    swapper.swap(AaveV2EthereumAssets.FRAX_UNDERLYING, AaveV2EthereumAssets.FRAX_ORACLE, 500);
    vm.stopPrank();

    vm.prank(swapper.ALLOWED_CALLER());
    swapper.cancelSwap(
      0x6397B4519D422D74e9fb7cea4B23ba1FbA2981D1, // Retrieved from logs
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV2EthereumAssets.FRAX_ORACLE,
      0,
      500
    );
  }

  function test_cancelSwap_successful_governanceCaller() public {
    COWSwapper swapper = new COWSwapper();

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    swapper.swap(AaveV2EthereumAssets.FRAX_UNDERLYING, AaveV2EthereumAssets.FRAX_ORACLE, 500);
    vm.stopPrank();

    vm.prank(AaveGovernanceV2.SHORT_EXECUTOR);
    swapper.cancelSwap(
      0x6397B4519D422D74e9fb7cea4B23ba1FbA2981D1, // Retrieved from logs
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV2EthereumAssets.FRAX_ORACLE,
      0,
      500
    );
  }

  function test_sendEthToCOWSwapper() public {
    address ethWale = 0xF977814e90dA44bFA03b6295A0616a897441aceC;
    // Testing that you can't send ETH to the contract directly since there's no fallback() or receive() function
    vm.startPrank(ethWale);
    (bool success, ) = address(new COWSwapper()).call{value: 1 ether}('');
    assertTrue(!success);
  }

  function test_rescueTokens_allowedCaller() public {
    COWSwapper swapper = new COWSwapper();

    assertEq(IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).balanceOf(address(swapper)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(address(swapper)), 0);

    uint256 usdtAmount = 1_000e6;
    uint256 daiAmount = 1_000e18;

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).safeTransfer(address(swapper), usdtAmount);
    vm.stopPrank();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).transfer(address(swapper), daiAmount);
    vm.stopPrank();

    assertEq(IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).balanceOf(address(swapper)), usdtAmount);
    assertEq(IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(address(swapper)), daiAmount);

    uint256 initialCollectorUsdtBalance = IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 initialCollectorDaiBalance = IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    address[] memory tokens = new address[](2);
    tokens[0] = AaveV2EthereumAssets.USDT_UNDERLYING;
    tokens[1] = AaveV2EthereumAssets.DAI_UNDERLYING;
    vm.startPrank(swapper.ALLOWED_CALLER());
    swapper.rescueTokens(tokens);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorUsdtBalance + usdtAmount
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      initialCollectorDaiBalance + daiAmount
    );
    assertEq(IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).balanceOf(address(swapper)), 0);
    assertEq(IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(address(swapper)), 0);
  }

  function test_rescueTokens_governanceCaller() public {
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

  function test_rescueTokens_revertsIfInvalidCaller() public {
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

  function test_depositIntoAave_successful() public {
    uint256 amount = 1_000e6;
    COWSwapper swapper = new COWSwapper();

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).safeTransfer(address(swapper), amount);
    vm.stopPrank();

    vm.startPrank(swapper.ALLOWED_CALLER());
    swapper.depositIntoAaveV2(AaveV2EthereumAssets.USDT_UNDERLYING);
    vm.stopPrank();
  }
}
