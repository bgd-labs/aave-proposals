// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolAddressesProvider} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {AaveMerkleDistributor} from './AaveMerkleDistributor.sol';
import {IRescue} from './interfaces/IRescue.sol';

/**
 * @title Aave_Eth_RescueMissionPhase_2_3_20233107
 * @author BGD labs
 * @notice This payload contract initializes the distribution on the distributor, updates the contracts with
 *         rescue function and transfers the tokens to rescue to the merkle distributor contract.
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract Aave_Eth_RescueMissionPhase_2_3_20233107 is IProposalGenericExecutor {
  AaveMerkleDistributor public immutable AAVE_MERKLE_DISTRIBUTOR;
  address public immutable V1_POOL_IMPL;
  address public immutable V2_POOL_IMPL;
  address public immutable V2_AMM_POOL_IMPL;
  address public immutable V2_RAI_A_TOKEN_IMPL;
  address public immutable V2_USDT_A_TOKEN_IMPL;

  address public constant V1_POOL = 0x398eC7346DcD622eDc5ae82352F02bE94C62d119;
  address public constant V1_BTC_A_TOKEN = 0xFC4B8ED459e00e5400be803A9BB3954234FD50e3;
  address public constant HOT_TOKEN = 0x6c6EE5e31d828De241282B9606C8e98Ea48526E2;

  ILendingPoolAddressesProvider public constant V1_POOL_ADDRESSES_PROVIDER =
    ILendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

  bytes32 public constant A_RAI_MERKLE_ROOT =
    0x3942426a49eecabdd3994e883ab25e0ec73c4f96f0b1f1b1b2f4c66f45878b26;

  bytes32 public constant A_BTC_MERKLE_ROOT =
    0xd5ab3ec5814e366baaeab62582f7ae7ddf2c6a5eaa7fee4cfb37905392238b5b;

  bytes32 public constant USDT_MERKLE_ROOT =
    0xc9f3d60e49d204c9efb8dc934df208af1b1dc466e167072153cb39984b0a47a2;

  bytes32 public constant DAI_MERKLE_ROOT =
    0xa5b01627e5dab7e836e128ecbf10060a4e7a6dd0318871a22a26f3cba7f80f27;

  bytes32 public constant GUSD_MERKLE_ROOT =
    0x4f887bd38b304046ea11e902fee4b378504e854ff62dc0fb4f0c8cae5a07aa6b;

  bytes32 public constant LINK_MERKLE_ROOT =
    0xdce06a9eace958878e687245785c4e81f49ea8d0f48f4b8a491eedc67cd2e3ba;

  bytes32 public constant HOT_MERKLE_ROOT =
    0x88c3cca89fd60d12d1bbb174584eebf65a4013fa6d32a0e8e1578393740af3c9;

  bytes32 public constant USDC_MERKLE_ROOT =
    0x55bd519868fb1519bfe6229b6a662a61401ecd8a4ef45254ed692a5a2ee29560;

  uint256 public constant A_RAI_RESCUE_AMOUNT = 1_481_160740870074804020;

  uint256 public constant A_BTC_RESCUE_AMOUNT = 192454215;

  uint256 public constant USDT_RESCUE_AMOUNT_AMM_POOL = 20_600_057405;

  uint256 public constant USDT_RESCUE_AMOUNT_A_USDT = 11_010e6;

  uint256 public constant DAI_RESCUE_AMOUNT = 22_000e18;

  uint256 public constant GUSD_RESCUE_AMOUNT = 19_994_86;

  uint256 public constant LINK_RESCUE_AMOUNT = 4_084e18;

  uint256 public constant HOT_RESCUE_AMOUNT = 1_046_391e18;

  uint256 public constant USDC_RESCUE_AMOUNT = 1_089_889717;

  /**
   * @param aaveMerkleDistributor distributor contract which will distribute the tokens to rescue.
   * @param v1PoolImpl address of the new aave v1 lending pool contract with rescue function.
   * @param v2PoolImpl address of the new aave v2 lending pool contract with rescue function.
   * @param v2AmmPoolImpl address of the new aave v2 amm lending pool contract with rescue function.
   * @param v2RaiATokenImpl address of the new aave v2 aToken contract for rai with rescue function.
   * @param v2UsdtATokenImpl address of the new aave v2 aToken contract for usdt with rescue function.
   */
  constructor(
    AaveMerkleDistributor aaveMerkleDistributor,
    address v1PoolImpl,
    address v2PoolImpl,
    address v2AmmPoolImpl,
    address v2RaiATokenImpl,
    address v2UsdtATokenImpl
  ) {
    AAVE_MERKLE_DISTRIBUTOR = aaveMerkleDistributor;
    V1_POOL_IMPL = v1PoolImpl;
    V2_POOL_IMPL = v2PoolImpl;
    V2_AMM_POOL_IMPL = v2AmmPoolImpl;
    V2_RAI_A_TOKEN_IMPL = v2RaiATokenImpl;
    V2_USDT_A_TOKEN_IMPL = v2UsdtATokenImpl;
  }

  function execute() external {
    _initializeDistribution();

    _updateContractsWithRescueFunction();

    _rescueTokensToMerkleDistributor();
  }

  function _initializeDistribution() internal {
    address[] memory tokens = new address[](8);
    tokens[0] = AaveV2EthereumAssets.RAI_A_TOKEN;
    tokens[1] = V1_BTC_A_TOKEN;
    tokens[2] = AaveV2EthereumAssets.USDT_UNDERLYING;
    tokens[3] = AaveV2EthereumAssets.DAI_UNDERLYING;
    tokens[4] = AaveV2EthereumAssets.GUSD_UNDERLYING;
    tokens[5] = AaveV2EthereumAssets.LINK_UNDERLYING;
    tokens[6] = HOT_TOKEN;
    tokens[7] = AaveV2EthereumAssets.USDC_UNDERLYING;

    bytes32[] memory merkleRoots = new bytes32[](8);
    merkleRoots[0] = A_RAI_MERKLE_ROOT;
    merkleRoots[1] = A_BTC_MERKLE_ROOT;
    merkleRoots[2] = USDT_MERKLE_ROOT;
    merkleRoots[3] = DAI_MERKLE_ROOT;
    merkleRoots[4] = GUSD_MERKLE_ROOT;
    merkleRoots[5] = LINK_MERKLE_ROOT;
    merkleRoots[6] = HOT_MERKLE_ROOT;
    merkleRoots[7] = USDC_MERKLE_ROOT;

    AAVE_MERKLE_DISTRIBUTOR.addDistributions(tokens, merkleRoots);
  }

  function _updateContractsWithRescueFunction() internal {
    // Set new pool implementaion with rescue function for Aave V1, V2, V2 Amm pools
    V1_POOL_ADDRESSES_PROVIDER.setLendingPoolImpl(V1_POOL_IMPL);
    AaveV2Ethereum.POOL_ADDRESSES_PROVIDER.setLendingPoolImpl(V2_POOL_IMPL);
    AaveV2EthereumAMM.POOL_ADDRESSES_PROVIDER.setLendingPoolImpl(V2_AMM_POOL_IMPL);

    // update aToken impl for aRai and aUsdt with rescue function
    AaveV2Ethereum.POOL_CONFIGURATOR.updateAToken(
      AaveV2EthereumAssets.RAI_UNDERLYING,
      address(V2_RAI_A_TOKEN_IMPL)
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.updateAToken(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      address(V2_USDT_A_TOKEN_IMPL)
    );
  }

  function _rescueTokensToMerkleDistributor() internal {
    IRescue(V1_POOL).rescueTokens(
      V1_BTC_A_TOKEN,
      address(AAVE_MERKLE_DISTRIBUTOR),
      A_BTC_RESCUE_AMOUNT
    );
    IRescue(V1_POOL).rescueTokens(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      address(AAVE_MERKLE_DISTRIBUTOR),
      LINK_RESCUE_AMOUNT
    );

    IRescue(address(AaveV2Ethereum.POOL)).rescueTokens(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      address(AAVE_MERKLE_DISTRIBUTOR),
      DAI_RESCUE_AMOUNT
    );
    IRescue(address(AaveV2Ethereum.POOL)).rescueTokens(
      AaveV2EthereumAssets.GUSD_UNDERLYING,
      address(AAVE_MERKLE_DISTRIBUTOR),
      GUSD_RESCUE_AMOUNT
    );
    IRescue(address(AaveV2Ethereum.POOL)).rescueTokens(
      HOT_TOKEN,
      address(AAVE_MERKLE_DISTRIBUTOR),
      HOT_RESCUE_AMOUNT
    );
    IRescue(address(AaveV2Ethereum.POOL)).rescueTokens(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      address(AAVE_MERKLE_DISTRIBUTOR),
      USDC_RESCUE_AMOUNT
    );
    IRescue(address(AaveV2EthereumAMM.POOL)).rescueTokens(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      address(AAVE_MERKLE_DISTRIBUTOR),
      USDT_RESCUE_AMOUNT_AMM_POOL
    );

    IRescue(AaveV2EthereumAssets.USDT_A_TOKEN).rescueTokens(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      address(AAVE_MERKLE_DISTRIBUTOR),
      USDT_RESCUE_AMOUNT_A_USDT
    );
    IRescue(AaveV2EthereumAssets.RAI_A_TOKEN).rescueTokens(
      AaveV2EthereumAssets.RAI_A_TOKEN,
      address(AAVE_MERKLE_DISTRIBUTOR),
      A_RAI_RESCUE_AMOUNT
    );
  }
}
