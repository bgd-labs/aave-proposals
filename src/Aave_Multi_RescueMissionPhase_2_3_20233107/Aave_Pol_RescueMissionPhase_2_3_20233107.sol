// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveMerkleDistributor} from './AaveMerkleDistributor.sol';
import {ILendingPoolConfigurator} from './interfaces/ILendingPoolConfigurator.sol';
import {IRescue} from './interfaces/IRescue.sol';

/**
 * @title Aave_Pol_RescueMissionPhase_2_3_20233107
 * @author BGD labs
 * @notice This payload contract initializes the distribution on the distributor, updates the contracts with
 *         rescue function and transfers the tokens to rescue to the merkle distributor contract.
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract Aave_Pol_RescueMissionPhase_2_3_20233107 is IProposalGenericExecutor {
  AaveMerkleDistributor public immutable AAVE_MERKLE_DISTRIBUTOR;
  address public immutable V2_POOL_IMPL;
  address public immutable V2_A_TOKEN_IMPL;

  bytes32 public constant WBTC_MERKLE_ROOT =
    0xc2cf7145003ab6cd9b31423261a1ec73bfd4df3bf07c0abee92be81bf2cbdb4c;

  bytes32 public constant A_DAI_MERKLE_ROOT =
    0xb45f53d15baa586913df15dfcdb6aece2fb0021d88deea0d0e24f766005b17d8;

  bytes32 public constant A_USDC_MERKLE_ROOT =
    0xf1d96a4c1c9e8d4591953b6dee8cbab19c4e98264217ff5b91191c99413cafbe;

  bytes32 public constant USDC_MERKLE_ROOT =
    0xc347790cda0bdd566160dfef55d52feccc07b334a3dd00974c957d08afab94bd;

  uint256 public constant WBTC_RESCUE_AMOUNT = 22994977;

  uint256 public constant A_DAI_RESCUE_AMOUNT = 4_250_580268097645600939;

  uint256 public constant A_USDC_RESCUE_AMOUNT = 514_131_378018;

  uint256 public constant USDC_RESCUE_AMOUNT = 4_515_242949;

  /**
   * @param aaveMerkleDistributor distributor contract which will distribute the tokens to rescue.
   * @param v2PoolImpl address of the new aave v2 lending pool contract with rescue function.
   * @param v2ATokenImpl address of the new aave v2 aToken contract with rescue function.
   */
  constructor(
    AaveMerkleDistributor aaveMerkleDistributor,
    address v2PoolImpl,
    address v2ATokenImpl
  ) {
    AAVE_MERKLE_DISTRIBUTOR = aaveMerkleDistributor;
    V2_POOL_IMPL = v2PoolImpl;
    V2_A_TOKEN_IMPL = v2ATokenImpl;
  }

  function execute() external {
    _initializeDistribution();

    _updateContractsWithRescueFunction();

    _rescueTokensToMerkleDistributor();
  }

  function _initializeDistribution() internal {
    address[] memory tokens = new address[](4);
    tokens[0] = AaveV2PolygonAssets.WBTC_UNDERLYING;
    tokens[1] = AaveV2PolygonAssets.DAI_A_TOKEN;
    tokens[2] = AaveV2PolygonAssets.USDC_A_TOKEN;
    tokens[3] = AaveV2PolygonAssets.USDC_UNDERLYING;

    bytes32[] memory merkleRoots = new bytes32[](4);
    merkleRoots[0] = WBTC_MERKLE_ROOT;
    merkleRoots[1] = A_DAI_MERKLE_ROOT;
    merkleRoots[2] = A_USDC_MERKLE_ROOT;
    merkleRoots[3] = USDC_MERKLE_ROOT;

    AAVE_MERKLE_DISTRIBUTOR.addDistributions(tokens, merkleRoots);
  }

  function _updateContractsWithRescueFunction() internal {
    // Set new pool implementaion with rescue function for Aave V2 pool
    AaveV2Polygon.POOL_ADDRESSES_PROVIDER.setLendingPoolImpl(V2_POOL_IMPL);

    // update aToken impl for aDai and aUsdc with rescue function
    ILendingPoolConfigurator(address(AaveV2Polygon.POOL_CONFIGURATOR)).updateAToken(
      ILendingPoolConfigurator.UpdateATokenInput({
        asset: AaveV2PolygonAssets.DAI_UNDERLYING,
        treasury: address(AaveV2Polygon.COLLECTOR),
        incentivesController: AaveV2Polygon.DEFAULT_INCENTIVES_CONTROLLER,
        name: 'Aave Matic Market DAI',
        symbol: 'amDAI',
        implementation: address(V2_A_TOKEN_IMPL),
        params: ''
      })
    );
    ILendingPoolConfigurator(address(AaveV2Polygon.POOL_CONFIGURATOR)).updateAToken(
      ILendingPoolConfigurator.UpdateATokenInput({
        asset: AaveV2PolygonAssets.USDC_UNDERLYING,
        treasury: address(AaveV2Polygon.COLLECTOR),
        incentivesController: AaveV2Polygon.DEFAULT_INCENTIVES_CONTROLLER,
        name: 'Aave Matic Market USDC',
        symbol: 'amUSDC',
        implementation: address(V2_A_TOKEN_IMPL),
        params: ''
      })
    );
  }

  function _rescueTokensToMerkleDistributor() internal {
    IRescue(address(AaveV2Polygon.POOL)).rescueTokens(
      AaveV2PolygonAssets.WBTC_UNDERLYING,
      address(AAVE_MERKLE_DISTRIBUTOR),
      WBTC_RESCUE_AMOUNT
    );
    IRescue(address(AaveV2Polygon.POOL)).rescueTokens(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      address(AAVE_MERKLE_DISTRIBUTOR),
      USDC_RESCUE_AMOUNT
    );

    IRescue(AaveV2PolygonAssets.DAI_A_TOKEN).rescueTokens(
      AaveV2PolygonAssets.DAI_A_TOKEN,
      address(AAVE_MERKLE_DISTRIBUTOR),
      A_DAI_RESCUE_AMOUNT
    );
    IRescue(AaveV2PolygonAssets.USDC_A_TOKEN).rescueTokens(
      AaveV2PolygonAssets.USDC_A_TOKEN,
      address(AAVE_MERKLE_DISTRIBUTOR),
      A_USDC_RESCUE_AMOUNT
    );
  }
}
