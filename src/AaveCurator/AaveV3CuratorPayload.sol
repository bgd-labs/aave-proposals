// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import {AaveCurator} from './AaveCurator.sol';
import {TokenAddresses} from './TokenAddresses.sol';

/**
 * @title Launch AaveCurator
 * @author Llama
 * Governance: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb4141f12f7ec8e037e6320912b5673fcc5909457d9f6201c018d5c15e5aa5083
 */
contract AaveV3CuratorPayload is IProposalGenericExecutor {
  function execute() external {
    uint256 balance = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR));

    AaveV2Ethereum.COLLECTOR.transfer(
        AaveV2EthereumAssets.USDC_UNDERLYING,
        address(this),
        balance
    );

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).approve(address(AaveV2Ethereum.POOL), balance);
    AaveV2Ethereum.POOL.deposit(
        AaveV2EthereumAssets.USDC_UNDERLYING,
        balance,
        address(AaveV2Ethereum.COLLECTOR),
        0
    );

    AaveCurator curator = new AaveCurator();

    curator.setAllowedToToken(AaveV2EthereumAssets.USDC_A_TOKEN, AaveV2EthereumAssets.USDC_ORACLE, true, true);

    TokenAddresses.TokenToSwap[] memory tokens = TokenAddresses.getTokensTotalBalance();
    uint256 addressesLength = tokens.length;
    for (uint256 i = 0; i < addressesLength; ++i) {
      TokenAddresses.TokenToSwap memory tokenToSwap = tokens[i];
      AaveV2Ethereum.COLLECTOR.transfer(
        tokenToSwap.token,
        address(curator),
        IERC20(tokenToSwap.token).balanceOf(address(AaveV2Ethereum.COLLECTOR))
      );

      curator.setAllowedFromToken(tokenToSwap.token, tokenToSwap.oracle, tokenToSwap.isEthFeed, true);

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

      curator.setAllowedFromToken(tokenToSwap.token, tokenToSwap.oracle, tokenToSwap.isEthFeed, true);

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
