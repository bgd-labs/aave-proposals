// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ProtocolV3_0_1TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {AaveV3StrategicAssets_20220622Payload} from './AaveV3StrategicAssets_20220622Payload.sol';

contract AaveV3StrategicAssets_20220622PayloadTest is ProtocolV3_0_1TestBase {
  AaveV3StrategicAssets_20220622Payload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17536310);

    payload = new AaveV3StrategicAssets_20220622Payload();
  }

  function test_payloadExecution() public {
    // Pre-execution assertions
    uint256 balanceAWethV2Before = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceAWethV3Before = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceEthBefore = address(AaveV2Ethereum.COLLECTOR).balance;

    uint256 balanceWstEthBefore = IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceREthBefore = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    // Post-execution assertions
    uint256 balanceAWethV2After = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceAWethV3After = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceEthAfter = address(AaveV2Ethereum.COLLECTOR).balance;

    uint256 balanceWstEthAfter = IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceREthAfter = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    // no more than 1_400 ether should be transfered out of v2 aETH
    assertGe(balanceAWethV2After, balanceAWethV2Before - 1_400 ether);
    // all eth should be transferred out
    assertEq(balanceEthAfter, 0);
    // no more than the rest (1800-1400-balance) should be transferred out of v3 aETH
    assertGe(
      balanceAWethV3After,
      balanceAWethV3Before - (1_800 ether - 1_400 ether - balanceEthBefore)
    );
    // wstETH and rETH balances should increase by roughly 800 x exchangeRate
    assertEq(balanceWstEthAfter, balanceWstEthBefore + 708_375617728822895268);
    assertEq(balanceREthAfter, balanceREthBefore + 744_068417600381302219);
  }
}
