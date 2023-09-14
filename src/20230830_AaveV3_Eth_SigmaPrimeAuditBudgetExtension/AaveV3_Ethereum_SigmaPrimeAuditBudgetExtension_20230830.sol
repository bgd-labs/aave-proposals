// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ICollector} from 'aave-address-book/common/ICollector.sol';

/**
 * @title Sigma Prime Audit Budget Extension
 * @author Sigma Prime
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x099a932f4e11a07b462f91257d2e5e899df25f6f43547644c681ac5addb38a9d
 * - Discussion: https://governance.aave.com/t/bgd-sigma-prime-audit-budget-extension/14357
 */
 contract AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830 {

  ICollector public constant COLLECTOR = AaveV3Ethereum.COLLECTOR;

  uint256 public constant FEE = 162000 * 1e6; // $162,000. Engagement fee as per proposal

  address public constant SIGP = 0x014D706F8C893166Da0C6C3343fF9359D1C08FA3;


  function execute() external {
    // Transfer fee
    COLLECTOR.transfer(AaveV2EthereumAssets.USDT_A_TOKEN, SIGP, FEE);
  }
}
