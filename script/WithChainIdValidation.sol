// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from 'forge-std/Script.sol';

/**
 * @dev Helper contract to enforce correct chain selection in scripts
 */
contract WithChainIdValidation is Script {
  constructor(uint256 chainId) {
    require(block.chainid == chainId, 'CHAIN_ID_MISMATCH');
  }
}
