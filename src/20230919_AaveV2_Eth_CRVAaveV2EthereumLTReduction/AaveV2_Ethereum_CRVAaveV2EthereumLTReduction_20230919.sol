// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title CRV Aave V2 Ethereum - LT Reduction
 * @author @yonikesel - ChaosLabsInc
 * - Snapshot: Direct to AIP
 * - Discussion: https://governance.aave.com/t/arfc-crv-aave-v2-ethereum-lt-reduction-09-19-2023/14890
 */
contract AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919 is IProposalGenericExecutor {
  uint256 public constant CRV_LIQUIDATION_THRESHOLD = 45_00; // 47 -> 45
  uint256 public constant CRV_LTV = 0; // unchanged
  uint256 public constant CRV_LIQUIDATION_BONUS = 10800; // unchanged

  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      CRV_LTV,
      CRV_LIQUIDATION_THRESHOLD,
      CRV_LIQUIDATION_BONUS
    );
  }
}
