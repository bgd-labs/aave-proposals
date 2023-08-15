// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_StataTokenOperationalUpdate_20230815} from './AaveV3_Ethereum_StataTokenOperationalUpdate_20230815.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {IStaticATokenFactory} from './IStaticATokenFactory.sol';

/**
 * @dev Test for AaveV3_Ethereum_StataTokenOperationalUpdate_20230815
 * command: make test-contract filter=AaveV3_Ethereum_StataTokenOperationalUpdate_20230815
 */
contract AaveV3_Ethereum_StataTokenOperationalUpdate_20230815_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_StataTokenOperationalUpdate_20230815 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17918848);
    proposal = new AaveV3_Ethereum_StataTokenOperationalUpdate_20230815();
  }

  function testProposalExecution() public {
    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    // trying to swap back admin
    address[] memory tokens = IStaticATokenFactory(AaveV3Ethereum.STATIC_A_TOKEN_FACTORY)
      .getStaticATokens();
    address newAdmin = proposal.NEW_ADMIN();
    vm.startPrank(newAdmin);
    for (uint256 i; i < tokens.length; i++) {
      assertEq(TransparentUpgradeableProxy(payable(tokens[i])).admin(), newAdmin);
      TransparentUpgradeableProxy(payable(tokens[i])).changeAdmin(AaveMisc.PROXY_ADMIN_ETHEREUM);
    }
    assertEq(TransparentUpgradeableProxy(payable(proposal.WAWETH())).admin(), newAdmin);
    assertEq(TransparentUpgradeableProxy(payable(proposal.WAUSDT())).admin(), newAdmin);
    assertEq(TransparentUpgradeableProxy(payable(proposal.WADAI())).admin(), newAdmin);
    assertEq(TransparentUpgradeableProxy(payable(proposal.WAUSDC())).admin(), newAdmin);
    vm.startPrank(AaveMisc.PROXY_ADMIN_ETHEREUM);
    for (uint256 i; i < tokens.length; i++) {
      assertEq(
        TransparentUpgradeableProxy(payable(tokens[i])).admin(),
        AaveMisc.PROXY_ADMIN_ETHEREUM
      );
    }
  }
}
