// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Set Price Oracle Sentinel on the Aave Optimism v3 addresses provider.
 * @author BGD Labs
 */
contract AaveV3OptPriceOracleSentinel_20230511_Payload is IProposalGenericExecutor {
  address public constant PRICE_ORACLE_SENTINEL = 0xB1ba0787Ca0A45f086F8CA03c97E7593636E47D5;

  function execute() external {
    AaveV3Optimism.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(PRICE_ORACLE_SENTINEL);
  }
}
