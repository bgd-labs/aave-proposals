// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IWrappedTokenGatewayV3} from 'aave-v3-periphery/misc/interfaces/IWrappedTokenGatewayV3.sol';

/**
 * @title TODO
 * @author BGD labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Eth_CrosschainInfrastructureFunding_20231907 is IProposalGenericExecutor {
  address public constant CROSSCHAIN_CONTROLLER = address(44);

  // ~ 20 proposals
  uint256 public constant ETH_AMOUNT = 2 ether;
  uint256 public constant LINK_AMOUNT = 9 ether;

  function execute() external {
    // transfer weth
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.WETH_A_TOKEN, address(this), ETH_AMOUNT);

    IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).approve(AaveV3Ethereum.WETH_GATEWAY, ETH_AMOUNT);

    // withdraw avax
    IWrappedTokenGatewayV3(AaveV3Ethereum.WETH_GATEWAY).withdrawETH(
      address(this),
      ETH_AMOUNT,
      CROSSCHAIN_CONTROLLER
    );

    // transfer Link to CC
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      CROSSCHAIN_CONTROLLER,
      LINK_AMOUNT
    );
  }
}
