// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ILendingPool} from 'aave-address-book/AaveV2.sol';

import {COWSwapper} from './COWSwapper20230801.sol';
import {TokenAddresses} from './TokenAddresses.sol';

/**
 * @title Swap assets to USDC and deposit into Aave V2
 * @author Llama
 * - Discussion: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb4141f12f7ec8e037e6320912b5673fcc5909457d9f6201c018d5c15e5aa5083
 */
contract AaveV2_Eth_TreasuryManagement_20230308 is IProposalGenericExecutor {
  address public constant RWA_aUSDC = 0x9Bc94a6A0D99fe559fA4DC5354ce3B96B210c210;
  address public constant RWA_POOL = 0xA1a8c33C9a9a9DE231b13a2271a7C09c11C849F1;

  function execute() external {
    COWSwapper swapper = new COWSwapper();

    TokenAddresses.TokenToWithdraw[] memory withdrawals = TokenAddresses.getTokensToWithdraw();
    uint256 withdrawalLength = withdrawals.length;
    for (uint256 i = 0; i < withdrawalLength; ++i) {
      TokenAddresses.TokenToWithdraw memory token = withdrawals[i];

      AaveV2Ethereum.COLLECTOR.transfer(
        token.aToken,
        address(this),
        IERC20(token.aToken).balanceOf(address(AaveV2Ethereum.COLLECTOR))
      );
      AaveV2Ethereum.POOL.withdraw(token.underlying, type(uint256).max, address(swapper));
    }

    address[] memory withdrawalsCollector = TokenAddresses.getTokensToWithdrawCollector();
    uint256 withdrawalCollectorLength = withdrawalsCollector.length;
    for (uint256 i = 0; i < withdrawalCollectorLength; ++i) {
      address token = withdrawalsCollector[i];

      AaveV2Ethereum.COLLECTOR.transfer(
        token,
        address(swapper),
        IERC20(token).balanceOf(address(AaveV2Ethereum.COLLECTOR))
      );
    }

    TokenAddresses.TokenToSwap[] memory tokens = TokenAddresses.getTokensToSwap();
    uint256 tokensLength = tokens.length;
    for (uint256 i = 0; i < tokensLength; ++i) {
      TokenAddresses.TokenToSwap memory tokenToSwap = tokens[i];
      swapper.swap(tokenToSwap.token, tokenToSwap.oracle, tokenToSwap.slippage);
    }

    // Withdraw RWA Market
    AaveV2Ethereum.COLLECTOR.transfer(
      RWA_aUSDC,
      address(this),
      IERC20(RWA_aUSDC).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    );
    ILendingPool(RWA_POOL).withdraw(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(swapper)
    );
  }
}
