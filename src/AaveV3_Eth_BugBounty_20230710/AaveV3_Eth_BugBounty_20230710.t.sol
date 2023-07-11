// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Eth_BugBounty_20230710} from './AaveV3_Eth_BugBounty_20230710.sol';

/**
 * @dev Test for AaveV3_Eth_BugBounty_20230710
 * command: make test-contract filter=AaveV3_Eth_BugBounty_20230710
 */
contract AaveV3_Eth_BugBounty_20230710_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17664219);
  }

  function testProposalExecution() public {
    AaveV3_Eth_BugBounty_20230710 proposal = new AaveV3_Eth_BugBounty_20230710();
    IERC20 aUSDT = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN);

    uint256 totalAmountToDisburse = proposal.FIRST_AMOUNT() +
      proposal.SECOND_AMOUNT() +
      proposal.THIRD_AMOUNT() +
      proposal.FOURTH_AMOUNT();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Eth_BugBounty_20230710',
      AaveV3Ethereum.POOL
    );

    uint256 amountCollectorBefore = aUSDT.balanceOf(address(AaveV3Ethereum.COLLECTOR));
    uint256 amountRecipientOneBefore = aUSDT.balanceOf(proposal.FIRST_RECIPIENT());
    uint256 amountRecipientTwoBefore = aUSDT.balanceOf(proposal.SECOND_RECIPIENT());
    uint256 amountRecipientThreeBefore = aUSDT.balanceOf(proposal.THIRD_RECIPIENT());
    uint256 amountRecipientFourBefore = aUSDT.balanceOf(proposal.FOURTH_RECIPIENT());

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 amountCollectorAfter = aUSDT.balanceOf(address(AaveV3Ethereum.COLLECTOR));
    uint256 amountRecipientOneAfter = aUSDT.balanceOf(proposal.FIRST_RECIPIENT());
    uint256 amountRecipientTwoAfter = aUSDT.balanceOf(proposal.SECOND_RECIPIENT());
    uint256 amountRecipientThreeAfter = aUSDT.balanceOf(proposal.THIRD_RECIPIENT());
    uint256 amountRecipientFourAfter = aUSDT.balanceOf(proposal.FOURTH_RECIPIENT());

    assertAlmostEq(amountCollectorBefore, amountCollectorAfter + totalAmountToDisburse);
    assertAlmostEq(amountRecipientOneBefore, amountRecipientOneAfter - proposal.FIRST_AMOUNT());
    assertAlmostEq(amountRecipientTwoBefore, amountRecipientTwoAfter - proposal.SECOND_AMOUNT());
    assertAlmostEq(amountRecipientThreeBefore, amountRecipientThreeAfter - proposal.THIRD_AMOUNT());
    assertAlmostEq(amountRecipientFourBefore, amountRecipientFourAfter - proposal.FOURTH_AMOUNT());

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Eth_BugBounty_20230710',
      AaveV3Ethereum.POOL
    );

    _noReservesConfigsChangesApartNewListings(allConfigsBefore, allConfigsAfter);
  }

  function assertAlmostEq(uint256 a, uint256 b) internal {
    uint256 diff = a > b ? a - b : b - a;
    assertLe(diff, 1);
  }
}

interface IERC20 {
  function balanceOf(address account) external view returns (uint256);
}
