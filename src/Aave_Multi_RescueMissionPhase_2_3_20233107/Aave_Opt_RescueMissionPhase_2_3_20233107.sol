// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveMerkleDistributor} from './AaveMerkleDistributor.sol';

/**
 * @title Aave_Opt_RescueMissionPhase_2_3_20233107
 * @author BGD labs
 * @notice This payload contract initializes the distribution on the distributor and
 *         transfers the tokens to rescue to the merkle distributor contract.
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract Aave_Opt_RescueMissionPhase_2_3_20233107 is IProposalGenericExecutor {
  AaveMerkleDistributor public immutable AAVE_MERKLE_DISTRIBUTOR;

  bytes32 public constant USDC_MERKLE_ROOT =
    0x056e6f6aa4c02ebecce9feda88005ba404ed49db9b1a974df40f97e9bc0406ad;

  uint256 public constant USDC_RESCUE_AMOUNT = 44_428_421035;

  /**
   * @param aaveMerkleDistributor distributor contract which will distribute the tokens to rescue.
   */
  constructor(AaveMerkleDistributor aaveMerkleDistributor) {
    AAVE_MERKLE_DISTRIBUTOR = aaveMerkleDistributor;
  }

  function execute() external {
    _initializeDistribution();

    _rescueTokensToMerkleDistributor();
  }

  function _initializeDistribution() internal {
    address[] memory tokens = new address[](1);
    tokens[0] = AaveV3OptimismAssets.USDC_UNDERLYING;

    bytes32[] memory merkleRoots = new bytes32[](1);
    merkleRoots[0] = USDC_MERKLE_ROOT;

    AAVE_MERKLE_DISTRIBUTOR.addDistributions(tokens, merkleRoots);
  }

  function _rescueTokensToMerkleDistributor() internal {
    AaveV3Optimism.POOL.rescueTokens(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      address(AAVE_MERKLE_DISTRIBUTOR),
      USDC_RESCUE_AMOUNT
    );
  }
}
