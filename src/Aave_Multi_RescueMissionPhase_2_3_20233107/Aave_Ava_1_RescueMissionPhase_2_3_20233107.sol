// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveMerkleDistributor} from './AaveMerkleDistributor.sol';

/**
 * @title Aave_Ava_1_RescueMissionPhase_2_3_20233107
 * @author BGD labs
 * @notice This payload contract initializes the distribution on the distributor, updates the contracts with
 *         rescue function - this payload should be executed by the owner of the addresses provider.
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract Aave_Ava_1_RescueMissionPhase_2_3_20233107 is IProposalGenericExecutor {
  AaveMerkleDistributor public immutable AAVE_MERKLE_DISTRIBUTOR;
  address public immutable V2_POOL_IMPL;

  address public constant USDTe_TOKEN = 0xc7198437980c041c805A1EDcbA50c1Ce5db95118;

  address public constant USDCe_TOKEN = 0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664;

  bytes32 public constant USDTe_MERKLE_ROOT =
    0xa9512e18f4e9bd831bd35f0b57ed065c33b1f91ae2dce6881eead4b6bf8b39c7;

  bytes32 public constant USDCe_MERKLE_ROOT =
    0xf6792060f920340a1c5d8caada0adb7bcdaac606ba7a1d6e1e7a3bec5125f4e5;

  uint256 public constant USDTe_RESCUE_AMOUNT = 1_772_206585;

  uint256 public constant USDCe_RESCUE_AMOUNT = 2_522_408895;

  /**
   * @param aaveMerkleDistributor distributor contract which will distribute the tokens to rescue.
   *  @param v2PoolImpl address of the new aave v2 lending pool contract with rescue function.
   */
  constructor(AaveMerkleDistributor aaveMerkleDistributor, address v2PoolImpl) {
    AAVE_MERKLE_DISTRIBUTOR = aaveMerkleDistributor;
    V2_POOL_IMPL = v2PoolImpl;
  }

  function execute() external {
    _initializeDistribution();

    _updateContractWithRescueFunction();
  }

  function _initializeDistribution() internal {
    address[] memory tokens = new address[](2);
    tokens[0] = USDTe_TOKEN;
    tokens[1] = USDCe_TOKEN;

    bytes32[] memory merkleRoots = new bytes32[](2);
    merkleRoots[0] = USDTe_MERKLE_ROOT;
    merkleRoots[1] = USDCe_MERKLE_ROOT;

    AAVE_MERKLE_DISTRIBUTOR.addDistributions(tokens, merkleRoots);
  }

  function _updateContractWithRescueFunction() internal {
    // Set new pool implementaion with rescue function for Aave V2 pool
    AaveV2Avalanche.POOL_ADDRESSES_PROVIDER.setLendingPoolImpl(V2_POOL_IMPL);
  }
}
