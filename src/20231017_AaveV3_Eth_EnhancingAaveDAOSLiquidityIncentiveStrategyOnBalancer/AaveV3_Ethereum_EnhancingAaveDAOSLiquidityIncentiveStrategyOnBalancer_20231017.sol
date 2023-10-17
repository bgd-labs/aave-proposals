// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Enhancing Aave DAO’s Liquidity Incentive Strategy on Balancer
 * @author Marc Zeller - Aave-Chan Initiative, Karpatkey
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xd1136b4db12346a95870f5a52ce02ef1bd4fb83cbbbf56c709aa14ae2d38659b
 * - Discussion: https://governance.aave.com/t/arfc-enhancing-aave-daos-liquidity-incentive-strategy-on-balancer/15061
 */
contract AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017 {
  using SafeERC20 for IERC20;

  address public constant AURA_DAO_ECOSYSTEM_FUND = 0x3BC0Cb287f74504347D50fe3aDA6d90214E6F512;
  address public constant AURA_DAO_TREASURY = 0xfc78f8e1Af80A3bF5A1783BB59eD2d1b10f78cA9;
  address public constant GLC = 0x205e795336610f5131Be52F09218AF19f0f3eC60;
  address public constant VEBAL_TOKEN = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;
  address public constant AURA_TOKEN = 0xC0c293ce456fF0ED870ADd98a0828Dd4d2903DBF;
  uint256 public constant AURA_AMOUNT = 477_088e18;
  uint256 public constant USDC_AMOUNT_TO_AURA = 200_000e6;
  uint256 public constant USDC_AMOUNT_TO_GLC = 400_000e6;
  uint256 public constant AAVE_AMOUNT = 2_965e18;

  function execute() external {
    // 1. AURA OTC DEAL

    // pull AURA from AURA_DAO_ECOSYSTEM_FUND wallet to collector, this will fail if they don't approve Short_executor
    IERC20(AURA_TOKEN).safeTransferFrom(
      AURA_DAO_TREASURY,
      address(AaveV2Ethereum.COLLECTOR),
      AURA_AMOUNT
    );

    // Transfer V3 aUSDC from COLLECTOR to Short_Executor

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_A_TOKEN,
      address(this),
      USDC_AMOUNT_TO_AURA
    );

    // withdraw aUSDC and convert it to USDC

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    // transfer USDC to AURA_DAO_USDC_RECIPIENT

    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).transfer(
      AURA_DAO_ECOSYSTEM_FUND,
      USDC_AMOUNT_TO_AURA
    );

    // transfer AAVE to AURA_DAO_TREASURY from ECOSYSTEM_RESERVE

    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
      AaveMisc.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AURA_DAO_TREASURY,
      AAVE_AMOUNT
    );

    // 2. Send funds to GLC

    // Transfer V2 aUSDC from COLLECTOR to Short_Executor

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      address(this),
      USDC_AMOUNT_TO_GLC
    );

    // withdraw aUSDC and convert it to USDC

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    // transfer USDC to GLC

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).transfer(
      GLC,
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(this))
    );

    // 3. Send veBAL to GLC

    // transfer veBAL to GLC from collector

    AaveV2Ethereum.COLLECTOR.transfer(
      VEBAL_TOKEN,
      GLC,
      IERC20(VEBAL_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    );
  }
}
