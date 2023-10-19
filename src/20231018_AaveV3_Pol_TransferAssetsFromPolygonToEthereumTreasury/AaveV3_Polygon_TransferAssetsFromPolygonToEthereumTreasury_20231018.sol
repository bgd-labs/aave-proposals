// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';


interface IAavePolEthERC20Bridge {
  function bridge(address token, uint256 amount) external;
}

/**
 * @title Transfer Assets From Polygon To Ethereum Treasury
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x33def6fd7bc3424fc47256ec0abdc3b75235d6f123dc1d15be7349066bc86319
 * - Discussion: https://governance.aave.com/t/arfc-transfer-assets-from-polygon-to-ethereum-treasury/15044
 */
contract AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018 is
  IProposalGenericExecutor
{

  IAavePolEthERC20Bridge public constant BRIDGE = IAavePolEthERC20Bridge(AaveMisc.AAVE_POL_ETH_BRIDGE);
  address public constant COLLECTOR = address(AaveV2Polygon.COLLECTOR);

  function execute() external {
    uint256 daiAmount = 1_500_000 * 1e18;
    uint256 crvAmount = IERC20(AaveV2PolygonAssets.CRV_A_TOKEN).balanceOf(COLLECTOR);
    uint256 balAmount = IERC20(AaveV2PolygonAssets.BAL_A_TOKEN).balanceOf(COLLECTOR);

    AaveV2Polygon.COLLECTOR.transfer(AaveV2PolygonAssets.DAI_A_TOKEN, address(this), daiAmount);
    AaveV2Polygon.COLLECTOR.transfer(AaveV2PolygonAssets.CRV_A_TOKEN, address(this), crvAmount);
    AaveV2Polygon.COLLECTOR.transfer(AaveV2PolygonAssets.BAL_A_TOKEN, address(this), balAmount);


    daiAmount = 
      AaveV2Polygon.POOL.withdraw(AaveV2PolygonAssets.DAI_UNDERLYING, type(uint256).max, AaveMisc.AAVE_POL_ETH_BRIDGE);

    crvAmount = 
      AaveV2Polygon.POOL.withdraw(AaveV2PolygonAssets.CRV_UNDERLYING, type(uint256).max, AaveMisc.AAVE_POL_ETH_BRIDGE);

    balAmount = 
      AaveV2Polygon.POOL.withdraw(AaveV2PolygonAssets.BAL_UNDERLYING, type(uint256).max, AaveMisc.AAVE_POL_ETH_BRIDGE);

    BRIDGE.bridge(AaveV2PolygonAssets.DAI_UNDERLYING, daiAmount);
    BRIDGE.bridge(AaveV2PolygonAssets.CRV_UNDERLYING, crvAmount);
    BRIDGE.bridge(AaveV2PolygonAssets.BAL_UNDERLYING, balAmount);
  }
}