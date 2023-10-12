// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {AaveV2EthereumAssets, AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import 'forge-std/console.sol';

/**
 * @title events-aip
 * @dev (1) Swap aEthUSDC & aEthUSDT to GHO; (2) Transfer GHO to Aave Co receiver address.
 * @author AaveCo
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xdcb072d9782c5160d824ee37919c1be35024bd5aec579a86fdfc024f60213ca1
 * - Discussion: https://governance.aave.com/t/temp-check-aave-events-sponsorship-budget/14953
 */
// https://github.com/bgd-labs/aave-proposals/blob/da71e84ff0ed0cad7d8c05520c7c76b77e9ddaf1/src/AgdAllowanceModification_20230817/AgdAllowanceModification_20230817.sol
contract AaveV3_Ethereum_EventsAip_20231010 is IProposalGenericExecutor {
  struct Asset {
    address underlying;
    address aToken;
    address oracle;
    uint256 amount;
  }
  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);
  address constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address constant CL_PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address constant RECEIVER = 0x1c037b3C22240048807cC9d7111be5d455F640bd;

  function execute() external {
    _transferTokens();
    _swapTokens();
  }

  function _transferTokens() internal {
    // Asset memory USDC = _getUSDCAsset();
    Asset memory USDT = _getUSDTAsset();
    Asset memory DAI = _getDAIAsset();

    // transfers aTokens to this contract
    AaveV3Ethereum.COLLECTOR.transfer(USDT.aToken, address(this), USDT.amount);
    AaveV3Ethereum.COLLECTOR.transfer(DAI.aToken, address(this), DAI.amount);
  }

  function _swapTokens() internal {
    // Asset memory USDC = _getUSDCAsset();
    Asset memory USDT = _getUSDTAsset();
    Asset memory GHO = _getGHOAsset();
    Asset memory DAI = _getDAIAsset();

    AaveSwapper swapper = AaveSwapper(AaveMisc.AAVE_SWAPPER_ETHEREUM);

    // Withdraws aTokens for swap
    uint256 executorUsdtBalance = AaveV3Ethereum.POOL.withdraw(
      USDT.underlying,
      USDT.amount,
      address(swapper)
    );

    uint256 executorDAIBalance = AaveV3Ethereum.POOL.withdraw(
      DAI.underlying,
      DAI.amount,
      address(swapper)
    );

    // Do Swaps
    swapper.swap(
      MILKMAN,
      CL_PRICE_CHECKER,
      USDT.underlying,
      GHO.underlying,
      USDT.oracle,
      GHO.oracle,
      RECEIVER,
      executorUsdtBalance,
      600
    );

    swapper.swap(
      MILKMAN,
      CL_PRICE_CHECKER,
      DAI.underlying,
      GHO.underlying,
      DAI.oracle,
      GHO.oracle,
      RECEIVER,
      executorDAIBalance,
      600
    );
  }

  function _getUSDTAsset() internal pure returns (Asset memory) {
    return
      Asset({
        underlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        aToken: AaveV3EthereumAssets.USDT_A_TOKEN,
        oracle: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D,
        amount: 275_000 * 1e6
      });
  }

  function _getGHOAsset() internal pure returns (Asset memory) {
    return
      Asset({
        underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        aToken: address(0), // no GHO atoken
        oracle: 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC,
        amount: 550_000 * 1e18
      });
  }

  function _getDAIAsset() internal pure returns (Asset memory) {
    return
      Asset({
        underlying: AaveV3EthereumAssets.DAI_UNDERLYING,
        aToken: AaveV3EthereumAssets.DAI_A_TOKEN,
        oracle: 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9,
        amount: 275_000 * 1e18
      });
  }
}
