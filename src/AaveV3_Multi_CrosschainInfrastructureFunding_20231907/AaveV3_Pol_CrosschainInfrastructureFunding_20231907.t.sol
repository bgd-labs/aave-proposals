// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Pol_CrosschainInfrastructureFunding_20231907} from './AaveV3_Pol_CrosschainInfrastructureFunding_20231907.sol';

/**
 * @dev Test for AaveV3_Pol_CrosschainInfrastructureFunding_20231907
 * command: make test-contract filter=AaveV3_Pol_CrosschainInfrastructureFunding_20231907
 */
contract AaveV3_Pol_CrosschainInfrastructureFunding_20231907_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 45267084);
  }

  function testProposalExecution() public {
    AaveV3_Pol_CrosschainInfrastructureFunding_20231907 proposal = new AaveV3_Pol_CrosschainInfrastructureFunding_20231907();

    uint256 maticBefore = address(proposal.CROSSCHAIN_CONTROLLER()).balance;
    uint256 linkBefore = IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).balanceOf(
      proposal.CROSSCHAIN_CONTROLLER()
    );

    assertEq(maticBefore, 0);
    assertEq(linkBefore, 0);

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    uint256 maticAfter = address(proposal.CROSSCHAIN_CONTROLLER()).balance;
    uint256 linkAfter = IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).balanceOf(
      proposal.CROSSCHAIN_CONTROLLER()
    );

    assertEq(maticAfter, proposal.MATIC_AMOUNT());
    assertEq(linkAfter, proposal.LINK_AMOUNT());
  }
}
