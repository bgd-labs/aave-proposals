// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IWrappedTokenGatewayV3} from 'aave-v3-periphery/misc/interfaces/IWrappedTokenGatewayV3.sol';

/**
 * @title TODO
 * @author BGD labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Pol_CrosschainInfrastructureFunding_20231907 is IProposalGenericExecutor {
  address public constant CROSSCHAIN_CONTROLLER = address(44);

  // ~ 20 proposals
  uint256 public constant MATIC_AMOUNT = 2040 ether;
  uint256 public constant LINK_AMOUNT = 114 ether;

  function execute() external {
    // transfer wmatic
    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.WMATIC_A_TOKEN,
      address(this),
      MATIC_AMOUNT
    );

    IERC20(AaveV3PolygonAssets.WMATIC_A_TOKEN).approve(AaveV3Polygon.WETH_GATEWAY, MATIC_AMOUNT);

    // withdraw matic
    IWrappedTokenGatewayV3(AaveV3Polygon.WETH_GATEWAY).withdrawETH(
      address(this),
      type(uint256).max,
      CROSSCHAIN_CONTROLLER
    );

    // transfer aPolLink token from the treasury to the current address
    AaveV3Polygon.COLLECTOR.transfer(AaveV3PolygonAssets.LINK_A_TOKEN, address(this), LINK_AMOUNT);

    // withdraw aPolLINK from the aave pool and receive LINK.e
    AaveV3Polygon.POOL.withdraw(
      AaveV3PolygonAssets.LINK_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    // transfer Link to the CC
    IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).transfer(
      CROSSCHAIN_CONTROLLER,
      IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).balanceOf(address(this))
    );
  }
}
