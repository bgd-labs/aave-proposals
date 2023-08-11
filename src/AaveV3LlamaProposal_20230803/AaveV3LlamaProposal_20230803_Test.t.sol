// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.16;

// testing libraries
import 'forge-std/Test.sol';

// contract dependencies
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets, ICollector} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveMisc, IStreamable} from 'aave-address-book/AaveMisc.sol';
import {AaveV3LlamaProposal_20230803} from 'src/AaveV3LlamaProposal_20230803/AaveV3LlamaProposal_20230803.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

// make test-contract filter=AaveV3LlamaProposal_20230803Test
contract AaveV3LlamaProposal_20230803Test is Test {
  IERC20 public constant AUSDC = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN);
  IERC20 public constant AAVE = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING);

  address public constant LLAMA_RECIPIENT = 0xb428C6812E53F843185986472bb7c1E25632e0f7;

  IStreamable public immutable STREAMABLE_ER = IStreamable(address(AaveMisc.ECOSYSTEM_RESERVE));

  uint256 public constant AAVE_STREAM_AMOUNT = 283230000000000000000;
  uint256 public constant AUSDC_STREAM_AMOUNT = 54659610000;
  uint256 public constant STREAM_DURATION = 57 days;
  uint256 public constant ACTUAL_AMOUNT_AUSDC =
    (AUSDC_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;
  uint256 public constant ACTUAL_AMOUNT_AAVE =
    (AAVE_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17839863);
  }

  function testExecute() public {
    AaveV3LlamaProposal_20230803 payload = new AaveV3LlamaProposal_20230803();
    uint256 currentAusdcStream = payload.COLLECTOR_aUSDC_STREAM();
    uint256 currentAaveStream = payload.ER_AAVE_STREAM();

    // get existing streams
    (, address recipient, , address tokenAddress, , , , ) = AaveV2Ethereum.COLLECTOR.getStream(
      currentAusdcStream
    );

    (, address erRecipient, , address erTokenAddress, , , , ) = STREAMABLE_ER.getStream(
      currentAaveStream
    );

    assertEq(recipient, LLAMA_RECIPIENT);
    assertEq(tokenAddress, AaveV2EthereumAssets.USDC_A_TOKEN);
    assertEq(erRecipient, LLAMA_RECIPIENT);
    assertEq(erTokenAddress, AaveV2EthereumAssets.AAVE_UNDERLYING);

    uint256 claimableAusdc = AaveV2Ethereum.COLLECTOR.balanceOf(
      currentAusdcStream,
      LLAMA_RECIPIENT
    );
    uint256 claimableAave = STREAMABLE_ER.balanceOf(currentAaveStream, LLAMA_RECIPIENT);

    // llama balances before
    uint256 ausdcBalanceBefore = AUSDC.balanceOf(LLAMA_RECIPIENT);
    uint256 aaveBalanceBefore = AAVE.balanceOf(LLAMA_RECIPIENT);

    // get next stream ids
    uint256 nextCollectorStreamId = AaveV2Ethereum.COLLECTOR.getNextStreamId();
    uint256 nextErStreamId = STREAMABLE_ER.getNextStreamId();

    // execute proposal
    GovHelpers.executePayload(
      vm,
      address(new AaveV3LlamaProposal_20230803()),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    // check that streams does not exist anymore
    vm.expectRevert('stream does not exist');
    AaveV2Ethereum.COLLECTOR.getStream(currentAusdcStream);

    vm.expectRevert('stream does not exist');
    STREAMABLE_ER.getStream(currentAaveStream);

    // check that llama's balances were updated
    uint256 ausdcBalanceAfter = AUSDC.balanceOf(LLAMA_RECIPIENT);
    uint256 aaveBalanceAfter = AAVE.balanceOf(LLAMA_RECIPIENT);

    assertEq(ausdcBalanceAfter, ausdcBalanceBefore + claimableAusdc);
    assertEq(aaveBalanceAfter, aaveBalanceBefore + claimableAave);

    // check that new streams are created
    assertNewAusdcStreamIsCreated(nextCollectorStreamId);
    assertNewAaveStreamIsCreated(nextErStreamId);

    // warp time, try to claim more - revert
    vm.startPrank(LLAMA_RECIPIENT);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);

    vm.expectRevert('amount exceeds the available balance');
    AaveV2Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamId, ACTUAL_AMOUNT_AUSDC + 1);

    vm.expectRevert('amount exceeds the available balance');
    STREAMABLE_ER.withdrawFromStream(nextErStreamId, ACTUAL_AMOUNT_AAVE + 1);

    // claim what is given and check final balances
    uint256 ausdcBalanceBeforeWithdraw = AUSDC.balanceOf(LLAMA_RECIPIENT);
    uint256 aaveBalanceBeforeWithdraw = AAVE.balanceOf(LLAMA_RECIPIENT);

    AaveV2Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamId, ACTUAL_AMOUNT_AUSDC);
    STREAMABLE_ER.withdrawFromStream(nextErStreamId, ACTUAL_AMOUNT_AAVE);

    uint256 ausdcBalanceFinal = AUSDC.balanceOf(LLAMA_RECIPIENT);
    uint256 aaveBalanceFinal = AAVE.balanceOf(LLAMA_RECIPIENT);

    assertEq(ausdcBalanceFinal, ausdcBalanceBeforeWithdraw + ACTUAL_AMOUNT_AUSDC);
    assertEq(aaveBalanceFinal, aaveBalanceBeforeWithdraw + ACTUAL_AMOUNT_AAVE);

    vm.stopPrank();
  }

  function assertNewAusdcStreamIsCreated(uint256 nextCollectorStreamId) private {
    (
      address senderUSDC,
      address recipientUSDC,
      uint256 depositUSDC,
      address tokenAddressUSDC,
      uint256 startTimeUSDC,
      uint256 stopTimeUSDC,
      uint256 remainingBalanceUSDC,

    ) = AaveV2Ethereum.COLLECTOR.getStream(nextCollectorStreamId);

    assertEq(senderUSDC, address(AaveV2Ethereum.COLLECTOR));
    assertEq(recipientUSDC, LLAMA_RECIPIENT);
    assertEq(depositUSDC, ACTUAL_AMOUNT_AUSDC);
    assertEq(tokenAddressUSDC, address(AUSDC));
    assertEq(stopTimeUSDC - startTimeUSDC, STREAM_DURATION);
    assertEq(remainingBalanceUSDC, ACTUAL_AMOUNT_AUSDC);
  }

  function assertNewAaveStreamIsCreated(uint256 nextErStreamId) private {
    (
      address senderAAVE,
      address recipientAAVE,
      uint256 depositAAVE,
      address tokenAddressAAVE,
      uint256 startTimeAAVE,
      uint256 stopTimeAAVE,
      uint256 remainingBalanceAAVE,

    ) = STREAMABLE_ER.getStream(nextErStreamId);

    assertEq(senderAAVE, AaveMisc.ECOSYSTEM_RESERVE);
    assertEq(recipientAAVE, LLAMA_RECIPIENT);
    assertEq(depositAAVE, ACTUAL_AMOUNT_AAVE);
    assertEq(tokenAddressAAVE, address(AAVE));
    assertEq(stopTimeAAVE - startTimeAAVE, STREAM_DURATION);
    assertEq(remainingBalanceAAVE, ACTUAL_AMOUNT_AAVE);
  }
}
