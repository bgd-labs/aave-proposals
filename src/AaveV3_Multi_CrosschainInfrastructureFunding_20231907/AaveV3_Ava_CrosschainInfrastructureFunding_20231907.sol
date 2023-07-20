// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IWrappedTokenGatewayV3} from 'aave-v3-periphery/misc/interfaces/IWrappedTokenGatewayV3.sol';

/**
 * @title TODO
 * @author BGD labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Ava_CrosschainInfrastructureFunding_20231907 is IProposalGenericExecutor {
  address public constant CROSSCHAIN_CONTROLLER = address(44);

  // ~ 20 proposals
  uint256 public constant AVAX_AMOUNT = 120 ether;
  uint256 public constant LINK_AMOUNT = 122 ether;

  function execute() external {
    // transfer wavax
    AaveV3Avalanche.COLLECTOR.transfer(
      AaveV3AvalancheAssets.WAVAX_A_TOKEN,
      address(this),
      AVAX_AMOUNT
    );

    IERC20(AaveV3AvalancheAssets.WAVAX_A_TOKEN).approve(AaveV3Avalanche.WETH_GATEWAY, AVAX_AMOUNT);

    // withdraw avax
    IWrappedTokenGatewayV3(AaveV3Avalanche.WETH_GATEWAY).withdrawETH(
      address(this),
      AVAX_AMOUNT,
      CROSSCHAIN_CONTROLLER
    );

    // transfer aAvaLink token from the treasury to the current address
    AaveV3Avalanche.COLLECTOR.transfer(
      AaveV3AvalancheAssets.LINKe_A_TOKEN,
      address(this),
      LINK_AMOUNT
    );

    // withdraw aAvaLINK from the aave pool and receive LINK.e
    AaveV3Avalanche.POOL.withdraw(
      AaveV3AvalancheAssets.LINKe_UNDERLYING,
      LINK_AMOUNT,
      address(this)
    );

    // transfer Link.e to the CC
    IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).transfer(
      CROSSCHAIN_CONTROLLER,
      IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).balanceOf(address(this)) // this will also transfer 0.1 LINK.e, which were accidently stuck on guardian
    );
  }
}
