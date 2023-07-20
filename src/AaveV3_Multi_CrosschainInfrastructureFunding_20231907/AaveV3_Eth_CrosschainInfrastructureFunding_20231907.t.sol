// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Eth_CrosschainInfrastructureFunding_20231907} from './AaveV3_Eth_CrosschainInfrastructureFunding_20231907.sol';

/**
 * @dev Test for AaveV3_Eth_CrosschainInfrastructureFunding_20231907
 * command: make test-contract filter=AaveV3_Eth_CrosschainInfrastructureFunding_20231907
 */
contract AaveV3_Eth_CrosschainInfrastructureFunding_20231907_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17727689);
  }

  function testProposalExecution() public {
    AaveV3_Eth_CrosschainInfrastructureFunding_20231907 proposal = new AaveV3_Eth_CrosschainInfrastructureFunding_20231907();

    uint256 ethBefore = address(proposal.CROSSCHAIN_CONTROLLER()).balance;
    uint256 linkBefore = IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(
      proposal.CROSSCHAIN_CONTROLLER()
    );

    assertEq(ethBefore, 0);
    assertEq(linkBefore, 0);

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 ethAfter = address(proposal.CROSSCHAIN_CONTROLLER()).balance;
    uint256 linkAfter = IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(
      proposal.CROSSCHAIN_CONTROLLER()
    );

    assertEq(ethAfter, proposal.ETH_AMOUNT());
    assertEq(linkAfter, proposal.LINK_AMOUNT());
  }
}
