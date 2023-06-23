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

    uint256 balanceAwstEthBefore = IERC20(AaveV3EthereumAssets.wstETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceArEthBefore = IERC20(AaveV3EthereumAssets.rETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 balanceWstEthBefore = IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceREthBefore = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertEq(balanceAWethV2Before, 1786462001889926403735);
    assertEq(balanceAWethV3Before, 258587244666787600985);
    assertEq(balanceEthBefore, 104548162283470274407);
    assertEq(balanceAwstEthBefore, 560437565049714601);
    assertEq(balanceArEthBefore, 352584449731577523);
    assertEq(balanceWstEthBefore, 0);
    assertEq(balanceREthBefore, 0);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    // Post-execution assertions

    uint256 balanceAWethV2After = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceAWethV3After = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceEthAfter = address(AaveV2Ethereum.COLLECTOR).balance;

    uint256 balanceAwstEthAfter = IERC20(AaveV3EthereumAssets.wstETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceArEthAfter = IERC20(AaveV3EthereumAssets.rETH_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 balanceWstEthAfter = IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceREthAfter = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertEq(balanceAWethV2After, 390846942816239323048);
    assertEq(balanceAWethV3After, 58598410745291062983);
    assertEq(balanceEthAfter, balanceEthBefore);
    assertEq(balanceAwstEthAfter, 708936055338620023248);
    assertEq(balanceArEthAfter, 744421002135286828252);
    assertEq(balanceWstEthAfter, 0);
    assertEq(balanceREthAfter, 0);
  }
}
