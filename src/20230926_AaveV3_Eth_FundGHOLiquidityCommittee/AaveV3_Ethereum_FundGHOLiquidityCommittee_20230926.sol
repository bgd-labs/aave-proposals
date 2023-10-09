// SPDX-License-Identifier: MIT

/*
   _      ΞΞΞΞ      _
  /_;-.__ / _\  _.-;_\
     `-._`'`_/'`.-'
         `\   /`
          |  /
         /-.(
         \_._\
          \ \`;
           > |/
          / //
          |//
          \(\
           ``
     defijesus.eth
*/

pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';

interface IWETH {
  function withdraw(uint256) external;
}

/**
 * @title Fund GHO Liquidity Committee
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x219cf8fbfa806b396728b7bf11e635ac4833ce92c9ea8e34f24a686e3cf0d132
 * - Discussion: https://governance.aave.com/t/arfc-treasury-manage-gho-liquidity-committee/14914
 */
contract AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926 is IProposalGenericExecutor {

  uint256 public constant DAI_AMOUNT = 406_000e18;
  uint256 public constant AWETH_AMOUNT = 5 ether;
  address public constant DAI_ORACLE = AaveV3EthereumAssets.DAI_ORACLE;
  address public constant GHO_ORACLE = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant LIQUIDITY_COMMITTEE = 0x205e795336610f5131Be52F09218AF19f0f3eC60;

  function execute() external {
    AaveSwapper SWAPPER = AaveSwapper(AaveMisc.AAVE_SWAPPER_ETHEREUM);
    
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.DAI_A_TOKEN, address(this), DAI_AMOUNT);
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.WETH_A_TOKEN, address(this), AWETH_AMOUNT);

    uint256 swapperDaiBalance = 
      AaveV3Ethereum.POOL.withdraw(AaveV3EthereumAssets.DAI_UNDERLYING, DAI_AMOUNT, AaveMisc.AAVE_SWAPPER_ETHEREUM);
    uint256 wethBalance = 
      AaveV3Ethereum.POOL.withdraw(AaveV3EthereumAssets.WETH_UNDERLYING, AWETH_AMOUNT, address(this));

    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).withdraw(wethBalance);

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      DAI_ORACLE,
      GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      swapperDaiBalance,
      50
    );

    (bool s, ) = LIQUIDITY_COMMITTEE.call{ value: wethBalance }("");
    require(s);
    AaveV3Ethereum.COLLECTOR.approve(AaveV3EthereumAssets.GHO_UNDERLYING, LIQUIDITY_COMMITTEE, DAI_AMOUNT);
  }
}
