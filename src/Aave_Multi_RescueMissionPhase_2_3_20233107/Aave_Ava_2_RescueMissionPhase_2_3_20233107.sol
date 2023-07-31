// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveMerkleDistributor} from './AaveMerkleDistributor.sol';
import {IRescue} from './interfaces/IRescue.sol';

/**
 * @title Aave_Ava_2_RescueMissionPhase_2_3_20233107
 * @author BGD labs
 * @notice This payload contract should be called after distribution is initialized and the contracts are updated with
 *         with rescue function - the payload should be executed by the pool admin to transfer the tokens to rescue to
 *         the merkle distributor contract.
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract Aave_Ava_2_RescueMissionPhase_2_3_20233107 is IProposalGenericExecutor {
  AaveMerkleDistributor public immutable AAVE_MERKLE_DISTRIBUTOR;

  address public constant USDTe_TOKEN = 0xc7198437980c041c805A1EDcbA50c1Ce5db95118;
  address public constant USDCe_TOKEN = 0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664;

  uint256 public constant USDTe_RESCUE_AMOUNT = 1_772_206585;
  uint256 public constant USDCe_RESCUE_AMOUNT = 2_522_408895;

  /**
   * @param aaveMerkleDistributor distributor contract which will distribute the tokens to rescue.
   */
  constructor(AaveMerkleDistributor aaveMerkleDistributor) {
    AAVE_MERKLE_DISTRIBUTOR = aaveMerkleDistributor;
  }

  function execute() external {
    IRescue(address(AaveV2Avalanche.POOL)).rescueTokens(
      USDTe_TOKEN,
      address(AAVE_MERKLE_DISTRIBUTOR),
      USDTe_RESCUE_AMOUNT
    );
    IRescue(address(AaveV2Avalanche.POOL)).rescueTokens(
      USDCe_TOKEN,
      address(AAVE_MERKLE_DISTRIBUTOR),
      USDCe_RESCUE_AMOUNT
    );
  }
}
