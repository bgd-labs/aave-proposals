// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title GHO Borrow Rate Update
 * @author Marc Zeller (@mzeller) - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4b6c0daa24e0268c86ad1aa1a0d3ee32456e6c1ee64aaaab3df4a58a1a0adc04
 * - Discussion: https://governance.aave.com/t/arfc-increase-gho-borrow-rate/14612
 */
contract AaveV3_Ethereum_GHOBorrowRateUpdate_20230904 {

  address public constant INTEREST_RATE_STRATEGY = 0x9210E5477dCA5bdF579ef0E1Ae84F9E823a5A3bA;

  function execute() external {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}