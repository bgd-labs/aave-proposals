// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';

import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {AaveV3CuratorPayload} from './AaveV3CuratorPayload.sol';
import {TokenAddresses} from './TokenAddresses.sol';

contract AaveV3CuratorPayload_Test is Test {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17708493);
  }

  function test_execute() public {
    uint256 withdrawAUSDT = 974_000e6;
    uint256 withdrawADAI = 974_000e18;

    AaveV3CuratorPayload payload = new AaveV3CuratorPayload();

    TokenAddresses.TokenToSwap[] memory tokens = TokenAddresses.getTokensTotalBalance();
    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(IERC20(tokens[i].token).balanceOf(address(AaveV2Ethereum.COLLECTOR)), 0);
    }

    uint256 balanceBeforeAUSDT = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeADAI = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    TokenAddresses.TokenToSwap[] memory tokensQty = TokenAddresses.getTokensTotalBalance();
    for (uint256 i = 0; i < tokensQty.length; i++) {
      assertGt(IERC20(tokensQty[i].token).balanceOf(address(AaveV2Ethereum.COLLECTOR)), 0);
    }

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    TokenAddresses.TokenToSwap[] memory tokensAfter = TokenAddresses.getTokensTotalBalance();
    for (uint256 i = 0; i < tokensAfter.length; i++) {
      assertEq(IERC20(tokensAfter[i].token).balanceOf(address(AaveV2Ethereum.COLLECTOR)), 0);
    }

    assertEq(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceBeforeAUSDT - withdrawAUSDT
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      balanceBeforeADAI - withdrawADAI
    );
  }
}
