// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthereumArc} from 'aave-address-book/AaveV2EthereumArc.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {TransparentProxyFactory} from 'solidity-utils/contracts/transparent-proxy/TransparentProxyFactory.sol';

import {AaveCurator} from './AaveCurator.sol';
import {TokenAddresses} from './TokenAddresses.sol';

/**
 * @title Launch AaveCurator
 * @author Llama
 * Governance: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb4141f12f7ec8e037e6320912b5673fcc5909457d9f6201c018d5c15e5aa5083
 */
contract AaveV3CuratorPayload is IProposalGenericExecutor {
    address public constant ARC_aUSDC = 0xd35f648C3C7f17cd1Ba92e5eac991E3EfcD4566d;

  function execute() external {
    // TODO: How to withdraw from ARC?
    // AaveV2Ethereum.COLLECTOR.transfer(
    //   ARC_aUSDC,
    //   address(this),
    //   IERC20(ARC_aUSDC).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    // );
    // AaveV2EthereumArc.POOL.withdraw(ARC_aUSDC, type(uint256).max, address(this));

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      address(this),
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    );

    uint256 balance = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(this));

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).approve(address(AaveV2Ethereum.POOL), balance);
    AaveV2Ethereum.POOL.deposit(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      balance,
      address(AaveV2Ethereum.COLLECTOR),
      0
    );

    AaveCurator curator = new AaveCurator();
    TransparentProxyFactory(AaveMisc.TRANSPARENT_PROXY_FACTORY_ETHEREUM).create(
      address(curator),
      AaveMisc.PROXY_ADMIN_ETHEREUM,
      abi.encodeWithSelector(AaveCurator.initialize.selector)
    );

    curator.setAllowedToToken(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      AaveV2EthereumAssets.USDC_ORACLE,
      true,
      true
    );

    TokenAddresses.TokenToSwap[] memory tokens = TokenAddresses.getTokensTotalBalance();
    uint256 addressesLength = tokens.length;
    for (uint256 i = 0; i < addressesLength; ++i) {
      TokenAddresses.TokenToSwap memory tokenToSwap = tokens[i];
      AaveV2Ethereum.COLLECTOR.transfer(
        tokenToSwap.token,
        address(curator),
        IERC20(tokenToSwap.token).balanceOf(address(AaveV2Ethereum.COLLECTOR))
      );

      curator.setAllowedFromToken(
        tokenToSwap.token,
        tokenToSwap.oracle,
        tokenToSwap.isEthFeed,
        true
      );

      curator.swap(
        tokenToSwap.token,
        AaveV2EthereumAssets.USDC_A_TOKEN,
        address(AaveV2Ethereum.COLLECTOR),
        IERC20(tokenToSwap.token).balanceOf(address(curator)),
        tokenToSwap.slippage,
        AaveCurator.TokenType.Standard
      );
    }

    TokenAddresses.TokenToSwap[] memory tokensTwo = TokenAddresses.getTokensSpecificBalance();
    uint256 addressesLengthTwo = tokensTwo.length;
    for (uint256 i = 0; i < addressesLengthTwo; ++i) {
      TokenAddresses.TokenToSwap memory tokenToSwap = tokensTwo[i];
      AaveV2Ethereum.COLLECTOR.transfer(
        tokenToSwap.token,
        address(curator),
        IERC20(tokenToSwap.token).balanceOf(address(AaveV2Ethereum.COLLECTOR))
      );

      curator.setAllowedFromToken(
        tokenToSwap.token,
        tokenToSwap.oracle,
        tokenToSwap.isEthFeed,
        true
      );

      curator.swap(
        tokenToSwap.token,
        AaveV2EthereumAssets.USDC_A_TOKEN,
        address(AaveV2Ethereum.COLLECTOR),
        IERC20(tokenToSwap.token).balanceOf(address(curator)),
        tokenToSwap.slippage,
        AaveCurator.TokenType.Standard
      );
    }
  }
}
