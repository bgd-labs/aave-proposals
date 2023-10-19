// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Aave Events & Sponsorship Budget Proposal
 * @dev (1) Swap aEthDAI & aEthUSDT to GHO; (2) Transfer GHO to Aave Co receiver address.
 * @author AaveCo
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xdcb072d9782c5160d824ee37919c1be35024bd5aec579a86fdfc024f60213ca1
 * - Discussion: https://governance.aave.com/t/temp-check-aave-events-sponsorship-budget/14953
 */
contract AaveV3_Ethereum_EventsAip_20231010 is IProposalGenericExecutor {
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant CL_PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant RECEIVER = 0x1c037b3C22240048807cC9d7111be5d455F640bd;

  uint256 public constant USDT_AMOUNT = 275_000e6;
  uint256 public constant DAI_AMOUNT = 275_000e18;

  address public constant USDT_ORACLE = 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D;
  address public constant GHO_ORACLE = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;
  address public constant DAI_ORACLE = 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9;

  uint256 public constant SWAP_SLIPPAGE = 100; // 1.00%

  function execute() external {
    // transfers aTokens to this contract
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDT_A_TOKEN,
      address(this),
      USDT_AMOUNT
    );
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.DAI_A_TOKEN, address(this), DAI_AMOUNT);

    AaveSwapper swapper = AaveSwapper(AaveMisc.AAVE_SWAPPER_ETHEREUM);

    // Withdraws aTokens for swap
    uint256 executorUsdtBalance = AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(swapper)
    );

    uint256 executorDAIBalance = AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(swapper)
    );

    // Do Swaps
    swapper.swap(
      MILKMAN,
      CL_PRICE_CHECKER,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      USDT_ORACLE,
      GHO_ORACLE,
      RECEIVER,
      executorUsdtBalance,
      SWAP_SLIPPAGE
    );

    swapper.swap(
      MILKMAN,
      CL_PRICE_CHECKER,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      DAI_ORACLE,
      GHO_ORACLE,
      RECEIVER,
      executorDAIBalance,
      SWAP_SLIPPAGE
    );
  }
}
