// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {IAaveOracle} from 'aave-address-book/AaveV2.sol';

/**
 * @title Prices operational update. Unify disabled fallback oracles
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV2EthUnifyFallbackOracles20230507 is IProposalGenericExecutor {
  address public constant AAVE_V1_ORACLE = 0x76B47460d7F7c5222cFb6b6A75615ab10895DDe4;

  function execute() external {
    AaveV2Ethereum.ORACLE.setFallbackOracle(address(0));
    AaveV2EthereumAMM.ORACLE.setFallbackOracle(address(0));
    IAaveOracle(AAVE_V1_ORACLE).setFallbackOracle(address(0));
  }
}
