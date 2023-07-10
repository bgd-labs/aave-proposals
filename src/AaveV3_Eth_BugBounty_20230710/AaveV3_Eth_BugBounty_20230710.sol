// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ICollector} from 'aave-address-book/common/ICollector.sol';

/**
 * @title AaveV3_Eth_BugBounty_20230710
 * @author BGD labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x6f70e60abd398e1ff04ff6a78cd313b69d47df84e42b790c14c273dc5ab31674
 * - Discussion: https://governance.aave.com/t/bgd-bug-bounties-proposal/13077
 */
contract AaveV3_Eth_BugBounty_20230710 {
  ICollector public constant COLLECTOR = AaveV3Ethereum.COLLECTOR;
  address public constant FIRST_RECIPIENT = 0xb91F64b7CD46e5cF5C0735d42D8292576aD45FAb; // Kankodu
  address public constant SECOND_RECIPIENT = 0x7dF98A6e1895fd247aD4e75B8EDa59889fa7310b; // Emanuele
  address public constant THIRD_RECIPIENT = 0x7Ac71b1944869C13b36Bfb25D7623723d288e6B2; // cmichel
  address public constant FOURTH_RECIPIENT = 0x192bDD30D272AabC2B1c3c719c518F0f2d10cc60; // Watchpug

  uint256 public constant FIRST_AMOUNT = 20_000e6;
  uint256 public constant SECOND_AMOUNT = 35_000e6;
  uint256 public constant THIRD_AMOUNT = 20_000e6;
  uint256 public constant FOURTH_AMOUNT = 10_000e6;

  function execute() external {
    // Transfer bug bounties
    COLLECTOR.transfer(AaveV2EthereumAssets.USDT_A_TOKEN, FIRST_RECIPIENT, FIRST_AMOUNT);
    COLLECTOR.transfer(AaveV2EthereumAssets.USDT_A_TOKEN, SECOND_RECIPIENT, SECOND_AMOUNT);
    COLLECTOR.transfer(AaveV2EthereumAssets.USDT_A_TOKEN, THIRD_RECIPIENT, THIRD_AMOUNT);
    COLLECTOR.transfer(AaveV2EthereumAssets.USDT_A_TOKEN, FOURTH_RECIPIENT, FOURTH_AMOUNT);
  }
}
