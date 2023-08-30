// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title CRV Aave V2 Ethereum - LT Reduction
 * @author @yonikesel - ChaosLabsInc
 * - Snapshot: Direct to AIP
 * - Discussion: https://governance.aave.com/t/arfc-crv-aave-v2-ethereum-lt-reduction-08-21-2023/14589
 */
contract AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822 is IProposalGenericExecutor {
  uint256 public constant CRV_LIQUIDATION_THRESHOLD = 47_00; // 49 -> 47
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
