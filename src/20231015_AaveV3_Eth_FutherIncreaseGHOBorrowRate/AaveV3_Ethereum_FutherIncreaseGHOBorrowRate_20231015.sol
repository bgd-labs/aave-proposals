// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Futher Increase GHO Borrow Rate
 * @author Marc Zeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x25557cd27107c25e5bd55f7e23af7665d16eba3ad8325f4dc5cc8ade9b7c6d1f
 * - Discussion: https://governance.aave.com/t/arfc-further-increase-gho-borrow-rate/15053
 */
contract AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015 {
  address public constant INTEREST_RATE_STRATEGY = 0x1255fC8DC8E76761995aCF544eea54f1B7fB0459;

  function execute() external {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
