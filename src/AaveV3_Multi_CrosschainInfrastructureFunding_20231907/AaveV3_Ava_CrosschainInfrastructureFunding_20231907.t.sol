// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ava_CrosschainInfrastructureFunding_20231907} from './AaveV3_Ava_CrosschainInfrastructureFunding_20231907.sol';

/**
 * @dev Test for AaveV3_Ava_CrosschainInfrastructureFunding_20231907
 * command: make test-contract filter=AaveV3_Ava_CrosschainInfrastructureFunding_20231907
 */
contract AaveV3_Ava_CrosschainInfrastructureFunding_20231907_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 32807122);
  }

  function testProposalExecution() public {
    AaveV3_Ava_CrosschainInfrastructureFunding_20231907 proposal = new AaveV3_Ava_CrosschainInfrastructureFunding_20231907();

    uint256 avaxBefore = address(proposal.CROSSCHAIN_CONTROLLER()).balance;
    uint256 linkBefore = IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).balanceOf(
      proposal.CROSSCHAIN_CONTROLLER()
    );

    assertEq(avaxBefore, 0);
    assertEq(linkBefore, 0);

    GovHelpers.executePayload(
      vm,
      address(proposal),
      0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian
    );

    uint256 avaxAfter = address(proposal.CROSSCHAIN_CONTROLLER()).balance;
    uint256 linkAfter = IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).balanceOf(
      proposal.CROSSCHAIN_CONTROLLER()
    );

    assertEq(avaxAfter, proposal.AVAX_AMOUNT());
    assertEq(linkAfter, proposal.LINK_AMOUNT());
  }
}
