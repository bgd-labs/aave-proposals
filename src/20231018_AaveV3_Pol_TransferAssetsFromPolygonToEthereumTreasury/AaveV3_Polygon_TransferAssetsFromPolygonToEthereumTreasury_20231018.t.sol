// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018} from './AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';

/**
 * @dev Test for AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018
 * command: make test-contract filter=AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018
 */
contract AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018_Test is
  ProtocolV3TestBase
{
  AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018 internal proposal;

  event Bridge(address token, uint256 amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49062641);
    proposal = AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018(0xCCAfBbbD68bb9B1A5F1C6ac948ED1944429F360a);
  }

  function testProposalExecution() public {
    address collector = address(AaveV2Polygon.COLLECTOR);

    uint256 daiAmount = 1_500_000 ether;

    uint256 daiCollectorBalanceBefore = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(collector);

    vm.expectEmit(true, true, false, false, AaveMisc.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV2PolygonAssets.DAI_UNDERLYING, daiAmount);
    vm.expectEmit(true, true, false, false, AaveMisc.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV2PolygonAssets.CRV_UNDERLYING, 9514859900351685761386);
    vm.expectEmit(true, true, false, false, AaveMisc.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV2PolygonAssets.BAL_UNDERLYING, 1867915444013591329250);
    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    uint256 daiCollectorBalanceAfter = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(collector);
    
    uint256 crvCollectorBalanceAfter = IERC20(AaveV2PolygonAssets.CRV_A_TOKEN).balanceOf(collector);
    
    uint256 balCollectorBalanceAfter = IERC20(AaveV2PolygonAssets.BAL_A_TOKEN).balanceOf(collector);

    assertApproxEqRel(daiCollectorBalanceAfter, daiCollectorBalanceBefore - daiAmount, 0.001e18);
    assertLe(crvCollectorBalanceAfter, 10e18);
    assertLe(balCollectorBalanceAfter, 10e18);

  }
}
