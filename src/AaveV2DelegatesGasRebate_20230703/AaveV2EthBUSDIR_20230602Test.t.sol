// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2DelegatesGasRebate_20230703} from 'src/AaveV2DelegatesGasRebate_20230703/AaveV2DelegatesGasRebate_20230703.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';

contract AaveV2DelegatesGasRebate_20230703Test is ProtocolV2TestBase {
  address public constant WETH = AaveV2EthereumAssets.WETH_UNDERLYING;
  string public constant WETH_SYMBOL = 'WETH';
  uint256 public constant Amount_DISTRIBUTED = 2.98e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17612038);
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

    address WETHPayload = address(new AaveV2DelegatesGasRebate_20230703());

    uint256 WETHBalanceBefore = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    GovHelpers.executePayload(vm, WETHPayload, AaveGovernanceV2.SHORT_EXECUTOR);

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
    // diff should be null as pools are not modified
    
    diffReports('pre-WETH-Payload-activation', 'post-WETH-Payload-activation');
  }
}
