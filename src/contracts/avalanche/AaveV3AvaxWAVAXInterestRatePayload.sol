// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title AaveV3AvaxWAVAXInterestRatePayload
 * @author Llama
 * @dev Amend the wAVAX interest rate parameters on the Aave Avalanche v3 Liquidity Pool.
 * Governance Forum Post: https://governance.aave.com/t/arfc-avalanche-wavax-interest-rate-upgrade/11561
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x08a9c7f13a3970cf9754ca52da51ca05d8baad8dc30927a2752344577b167f09
 */
contract AaveV3AvaxWAVAXInterestRatePayload is IProposalGenericExecutor {
  address public constant INTEREST_RATE_STRATEGY = 0x2Cbf7856f51660Aae066afAbaBf9C854FA6BD11f;

  function execute() external {
    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV3AvalancheAssets.WAVAX_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
