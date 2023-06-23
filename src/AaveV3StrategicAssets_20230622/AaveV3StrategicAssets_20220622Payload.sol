// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IRocketPoolDeposit} from './IRocketPoolDeposit.sol';
import {IWeth} from './IWeth.sol';
import {ILido} from './ILido.sol';
import {IWstEth} from './IWstEth.sol';

/**
 * @title Acquire wstETH and rETH
 * @author Llama
 * @dev This proposal swaps aWETH holdings for wstETH and rETH
 * Governance: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205/4
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x5bcb6dddf3e65597db2f0e8300edca5737788fcf6c63ca90024a8b4e685b40fe
 */
contract AaveV3StrategicAssets_20220622Payload is IProposalGenericExecutor {
  uint256 public constant WSTETH_TO_ACQUIRE = 800 ether;
  uint256 public constant RETH_TO_ACQUIRE = 800 ether;

  IRocketPoolDeposit private constant ROCKET_POOL =
    IRocketPoolDeposit(0xDD3f50F8A6CafbE9b31a427582963f465E745AF8);
  IWeth private constant WETH = IWeth(AaveV2EthereumAssets.WETH_UNDERLYING);

  address private constant STETH = AaveV2EthereumAssets.stETH_UNDERLYING;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.transfer(AaveV2EthereumAssets.WETH_A_TOKEN, address(this), 1_400e18);

    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.WETH_A_TOKEN, address(this), 200e18);

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    IWeth(AaveV2EthereumAssets.WETH_UNDERLYING).withdraw(
      IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(this))
    );

    ROCKET_POOL.deposit{value: RETH_TO_ACQUIRE}();

    ILido(STETH).submit{value: WSTETH_TO_ACQUIRE}(address(0));
    IERC20(STETH).approve(
      AaveV3EthereumAssets.wstETH_UNDERLYING,
      IERC20(STETH).balanceOf(address(this))
    );
    IWstEth(AaveV3EthereumAssets.wstETH_UNDERLYING).wrap(IERC20(STETH).balanceOf(address(this)));

    IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).approve(
      address(AaveV3Ethereum.POOL),
      IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(address(this))
    );
    IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).approve(
      address(AaveV3Ethereum.POOL),
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(this))
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.wstETH_UNDERLYING,
      IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(address(this)),
      address(AaveV3Ethereum.COLLECTOR),
      0
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.rETH_UNDERLYING,
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(this)),
      address(AaveV3Ethereum.COLLECTOR),
      0
    );
  }
}
