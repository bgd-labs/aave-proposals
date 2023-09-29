// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveMisc, IStreamable} from 'aave-address-book/AaveMisc.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925} from './AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925
 * command: make test-contract filter=AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925
 */
contract AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925_Test is ProtocolV2TestBase {
  AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925 internal proposal;

  address public constant CENTRIFUGE = 0xC8B2404b84998C3f7a7Cc8459143309465FC97Da;
  address public constant USDC = AaveV2EthereumAssets.USDC_UNDERLYING;
  address public constant AAVE = AaveV2EthereumAssets.AAVE_UNDERLYING;
  address public constant AAVE_ECOSYSTEM_RESERVE = AaveMisc.ECOSYSTEM_RESERVE;
  IStreamable public constant STREAMABLE_AAVE_ECOSYSTEM_RESERVE =
    IStreamable(AAVE_ECOSYSTEM_RESERVE);
  uint256 public constant STREAM_AMOUNT = 500e18;
  uint256 public constant STREAM_DURATION = 720 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT =
    (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;
  uint256 public constant USDC_AMOUNT = 50_000e6;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18212877);
    proposal = new AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925();
  }

  function testProposalExecution() public {
    uint256 balanceBeforeStable = IERC20(USDC).balanceOf(CENTRIFUGE);

    uint256 balanceBeforeAave = IERC20(AAVE).balanceOf(CENTRIFUGE);

    uint256 nextEcosystemReserveStreamID = STREAMABLE_AAVE_ECOSYSTEM_RESERVE.getNextStreamId();

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 balanceAfterStable = IERC20(USDC).balanceOf(CENTRIFUGE);

    assertApproxEqAbs(balanceAfterStable, balanceBeforeStable + USDC_AMOUNT, 1 ether);

    (
      address senderAave,
      address recipientAave,
      uint256 depositAave,
      address tokenAddressAave,
      uint256 startTimeAave,
      uint256 stopTimeAave,
      uint256 remainingBalanceAave,

    ) = STREAMABLE_AAVE_ECOSYSTEM_RESERVE.getStream(nextEcosystemReserveStreamID);

    assertEq(senderAave, AAVE_ECOSYSTEM_RESERVE);
    assertEq(recipientAave, CENTRIFUGE);
    assertEq(depositAave, ACTUAL_STREAM_AMOUNT);
    assertEq(tokenAddressAave, address(AAVE));
    assertEq(stopTimeAave - startTimeAave, STREAM_DURATION);
    assertEq(remainingBalanceAave, ACTUAL_STREAM_AMOUNT);

    vm.startPrank(CENTRIFUGE);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);

    uint256 currentAaveCENTRIFUGEStreamBalance = STREAMABLE_AAVE_ECOSYSTEM_RESERVE.balanceOf(
      nextEcosystemReserveStreamID,
      CENTRIFUGE
    );

    STREAMABLE_AAVE_ECOSYSTEM_RESERVE.withdrawFromStream(
      nextEcosystemReserveStreamID,
      currentAaveCENTRIFUGEStreamBalance
    );

    assertEq(
      IERC20(AAVE).balanceOf(CENTRIFUGE) >= balanceBeforeAave + ACTUAL_STREAM_AMOUNT,
      true
    );

    vm.stopPrank();
  }
}
