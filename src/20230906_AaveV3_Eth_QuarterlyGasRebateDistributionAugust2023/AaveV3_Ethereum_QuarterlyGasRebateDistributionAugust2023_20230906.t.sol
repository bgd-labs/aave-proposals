// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906} from 'src/20230906_AaveV3_Eth_QuarterlyGasRebateDistributionAugust2023/AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';

// make test-contract filter=AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906

contract AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906Test is
  ProtocolV2TestBase
{
  address public constant WETH = AaveV2EthereumAssets.WETH_UNDERLYING;
  string public constant WETH_SYMBOL = 'WETH';
  uint256 public constant Amount_DISTRIBUTED = 2.7e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18091458);
  }

  function testWETH() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-WETH-Payload-activation',
      AaveV2Ethereum.POOL
    );

    ReserveConfig memory configWETHBefore = _findReserveConfigBySymbol(
      allConfigsBefore,
      WETH_SYMBOL
    );

    address WETHPayload = address(
      new AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906()
    );

    uint256 shortExecutorETHBalanceBefore = address(AaveGovernanceV2.SHORT_EXECUTOR).balance;

    uint256 WETHBalanceBefore = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    GovHelpers.executePayload(vm, WETHPayload, AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 shortExecutorETHBalanceAfter = address(AaveGovernanceV2.SHORT_EXECUTOR).balance;

    // check balances are correct
    uint256 WETHBalanceAfter = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    assertApproxEqAbs(WETHBalanceAfter, 0, 1500 ether, 'WETH_LEFTOVER');
    assertEq(WETHBalanceAfter, WETHBalanceBefore - Amount_DISTRIBUTED, 'WETH_LEFTOVER');
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-WETH-Payload-activation',
      AaveV2Ethereum.POOL
    );

    // check it's not bricked
    ReserveConfig memory configWETHAfter = _findReserveConfigBySymbol(allConfigsAfter, WETH_SYMBOL);
    _withdraw(
      configWETHAfter,
      AaveV2Ethereum.POOL,
      0x0CD420966fce68BaD79cD82c9A360636Cf898c1e,
      1 ether
    ); // aWETH whale

    // check there are no unexpected changes
    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      configWETHBefore.underlying
    );

    // check ETH balance is same as before 
    assertEq(shortExecutorETHBalanceAfter, shortExecutorETHBalanceBefore);

    // diff should be null as pools are not modified

    diffReports('pre-WETH-Payload-activation', 'post-WETH-Payload-activation');
  }
}
