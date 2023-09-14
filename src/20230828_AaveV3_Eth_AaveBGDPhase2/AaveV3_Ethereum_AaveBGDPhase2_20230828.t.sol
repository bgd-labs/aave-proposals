// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets, ICollector} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3_Ethereum_AaveBGDPhase2_20230828} from './AaveV3_Ethereum_AaveBGDPhase2_20230828.sol';

/**
 * @dev Test for AaveV3_Ethereum_AaveBGDPhase2_20230828
 * command: make test-contract filter=AaveV3_Ethereum_AaveBGDPhase2_20230828
 */
contract AaveV3_Ethereum_AaveBGDPhase2_20230828_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_AaveBGDPhase2_20230828 internal proposal;

  address public constant BGD_RECIPIENT = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;

  address public constant UPFRONT_STABLE = AaveV2EthereumAssets.DAI_A_TOKEN;
  address public constant AAVE = AaveV2EthereumAssets.AAVE_UNDERLYING;

  address public constant STREAM_STABLE = AaveV3EthereumAssets.DAI_A_TOKEN;

  uint256 public constant STABLE_UPFRONT_AMOUNT = 1_140_000 ether;
  uint256 public constant AAVE_UPFRONT_AMOUNT = 3_600 ether;

  uint256 public constant STREAMS_DURATION = 180 days;
  uint256 public constant STABLE_STREAM_AMOUNT = 760_000 ether;
  uint256 public constant ACTUAL_STREAM_AMOUNT_STABLE =
    (STABLE_STREAM_AMOUNT / STREAMS_DURATION) * STREAMS_DURATION;
  uint256 public constant AAVE_STREAM_AMOUNT = 2_400 ether;
  uint256 public constant ACTUAL_STREAM_AMOUNT_AAVE =
    (AAVE_STREAM_AMOUNT / STREAMS_DURATION) * STREAMS_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18026110);
    proposal = new AaveV3_Ethereum_AaveBGDPhase2_20230828();
  }

  function testProposalExecution() public {
    // ---
    // Upfront payments
    // ---

    uint256 balanceBeforeStable = IERC20(UPFRONT_STABLE).balanceOf(BGD_RECIPIENT);
    uint256 balanceBeforeAave = IERC20(AAVE).balanceOf(BGD_RECIPIENT);

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    // Taking into account the 1 wei imprecion on aToken
    assertApproxEqAbs(
      IERC20(UPFRONT_STABLE).balanceOf(BGD_RECIPIENT),
      balanceBeforeStable + STABLE_UPFRONT_AMOUNT,
      1
    );
    assertEq(IERC20(AAVE).balanceOf(BGD_RECIPIENT), balanceBeforeAave + AAVE_UPFRONT_AMOUNT);

    // ---
    // Streams
    // ---

    uint256 stablesStreamId = ICollector(AaveV2Ethereum.COLLECTOR).getNextStreamId() - 1;
    uint256 aaveStreamId = ICollector(AaveMisc.ECOSYSTEM_RESERVE).getNextStreamId() - 1;

    _validateStablesStreamConfig(stablesStreamId);
    _validateAaveStreamConfig(aaveStreamId);

    uint256 timeWarp = 1 hours;
    vm.warp(block.timestamp + timeWarp);

    _validateStablesStreamWithdrawal(stablesStreamId, timeWarp);
    _validateAaveStreamWithdrawal(aaveStreamId, timeWarp);
  }

  function _validateStablesStreamConfig(uint256 streamId) internal {
    (
      address sender,
      address recipient,
      uint256 amount,
      address token,
      uint256 startTime,
      uint256 endTime,
      uint256 toClaim,

    ) = AaveV2Ethereum.COLLECTOR.getStream(streamId);

    assertEq(sender, address(AaveV2Ethereum.COLLECTOR));
    assertEq(recipient, BGD_RECIPIENT);
    assertEq(amount, ACTUAL_STREAM_AMOUNT_STABLE);
    assertEq(token, STREAM_STABLE);
    assertEq(endTime - startTime, STREAMS_DURATION);
    assertEq(toClaim, ACTUAL_STREAM_AMOUNT_STABLE);
  }

  function _validateAaveStreamConfig(uint256 streamId) internal {
    (
      address sender,
      address recipient,
      uint256 amount,
      address token,
      uint256 startTime,
      uint256 endTime,
      uint256 toClaim,

    ) = ICollector(AaveMisc.ECOSYSTEM_RESERVE).getStream(streamId);

    assertEq(sender, address(AaveMisc.ECOSYSTEM_RESERVE));
    assertEq(recipient, BGD_RECIPIENT);
    assertEq(amount, ACTUAL_STREAM_AMOUNT_AAVE);
    assertEq(token, AaveV2EthereumAssets.AAVE_UNDERLYING);
    assertEq(endTime - startTime, STREAMS_DURATION);
    assertEq(toClaim, ACTUAL_STREAM_AMOUNT_AAVE);
  }

  function _validateStablesStreamWithdrawal(uint256 streamId, uint256 timeWarp) internal {
    uint256 balanceBefore = IERC20(STREAM_STABLE).balanceOf(BGD_RECIPIENT);

    vm.startPrank(BGD_RECIPIENT);
    uint256 streamSpeed = ACTUAL_STREAM_AMOUNT_STABLE / STREAMS_DURATION;
    uint256 accrued = streamSpeed * timeWarp;

    AaveV2Ethereum.COLLECTOR.withdrawFromStream(streamId, accrued);

    uint256 balanceAfter = IERC20(STREAM_STABLE).balanceOf(BGD_RECIPIENT);
    assertEq(balanceAfter, balanceBefore + accrued);
    vm.stopPrank();
  }

  function _validateAaveStreamWithdrawal(uint256 streamId, uint256 timeWarp) internal {
    uint256 balanceBefore = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(BGD_RECIPIENT);

    vm.startPrank(BGD_RECIPIENT);
    uint256 streamSpeed = ACTUAL_STREAM_AMOUNT_AAVE / STREAMS_DURATION;
    uint256 accrued = streamSpeed * timeWarp;

    ICollector(AaveMisc.ECOSYSTEM_RESERVE).withdrawFromStream(streamId, accrued);

    uint256 balanceAfter = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING).balanceOf(BGD_RECIPIENT);
    assertEq(balanceAfter, balanceBefore + accrued);
    vm.stopPrank();
  }
}
