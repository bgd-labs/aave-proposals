// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';

import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {AaveV2_Eth_ServiceProviders_20231907} from './AaveV2_Eth_ServiceProviders_20231907.sol';

contract AaveV3CuratorPayload_Test is Test {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17765420);
  }

  function test_execute() public {
    AaveV2_Eth_ServiceProviders_20231907 payload = new AaveV2_Eth_ServiceProviders_20231907();

    uint256 balanceBeforeAUSDC = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
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

    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(payload)),
      0
    );

    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(payload)),
      0
    );

    assertGt(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceBeforeAUSDC
    );

    assertApproxEqAbs(IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceBeforeAUSDT - payload.AMOUNT_USDT(), 1);

    assertApproxEqAbs(IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceBeforeADAI - payload.AMOUNT_DAI(), 1);
  }
}
