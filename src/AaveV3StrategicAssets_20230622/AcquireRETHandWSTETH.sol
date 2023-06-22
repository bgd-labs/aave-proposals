pragma solidity 0.8.19;

import {console2} from 'forge-std/Test.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IRocketPoolDeposit} from './IRocketPoolDeposit.sol';
import {IWeth} from './IWeth.sol';
import {ILido} from './ILido.sol';
import {IWstEth} from './IWstEth.sol';

contract AcquireRETHandWSTETH {
  uint256 public constant WSTETH_TO_ACQUIRE = 800e18;
  uint256 public constant RETH_TO_ACQUIRE = 800e18;

  IRocketPoolDeposit private constant ROCKET_POOL =
    IRocketPoolDeposit(0xDD3f50F8A6CafbE9b31a427582963f465E745AF8);
  IWeth private constant WETH = IWeth(AaveV2EthereumAssets.WETH_UNDERLYING);

  address private constant STETH = 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84;

  function swap() external {
    IWeth(AaveV2EthereumAssets.WETH_UNDERLYING).withdraw(
      IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(this))
    );

    ROCKET_POOL.deposit{value: RETH_TO_ACQUIRE}();

    ILido(STETH).submit{value: WSTETH_TO_ACQUIRE}(address(0));
    IERC20(STETH).approve(AaveV3EthereumAssets.wstETH_UNDERLYING, IERC20(STETH).balanceOf(address(this)));
    IWstEth(AaveV3EthereumAssets.wstETH_UNDERLYING).wrap(IERC20(STETH).balanceOf(address(this)));

    IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).approve(address(AaveV3Ethereum.POOL), IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(address(this)));
    IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).approve(address(AaveV3Ethereum.POOL), IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(this)));

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

  receive() external payable {}
}
