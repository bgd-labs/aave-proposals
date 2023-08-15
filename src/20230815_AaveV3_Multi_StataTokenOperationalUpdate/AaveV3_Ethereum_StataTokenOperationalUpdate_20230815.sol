// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {IStaticATokenFactory} from './IStaticATokenFactory.sol';

/**
 * @title stataToken operational update
 * @author BGD labs
 * - Discussion: https://governance.aave.com/t/bgd-statatoken-operational-update/14497
 */
contract AaveV3_Ethereum_StataTokenOperationalUpdate_20230815 is IProposalGenericExecutor {
  address public constant NEW_ADMIN = 0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f;

  function execute() external {
    address[] memory tokens = IStaticATokenFactory(AaveV3Ethereum.STATIC_A_TOKEN_FACTORY)
      .getStaticATokens();
    for (uint256 i; i < tokens.length; i++) {
      ProxyAdmin(AaveMisc.PROXY_ADMIN_ETHEREUM).changeProxyAdmin(
        TransparentUpgradeableProxy(payable(tokens[i])),
        NEW_ADMIN
      );
    }
  }
}
