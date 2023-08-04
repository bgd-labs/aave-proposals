// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.16;

// testing libraries
import 'forge-std/Test.sol';

// contract dependencies
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets, ICollector} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveMisc, IStreamable} from 'aave-address-book/AaveMisc.sol';
import {AaveV3LlamaProposal_20230803} from 'src/AaveV3LlamaProposal_20230803/AaveV3LlamaProposal_20230803.sol';
import {DeployMainnetProposal} from 'script/DeployMainnetProposal.s.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';


// make test-contract filter=AaveV3LlamaProposal_20230803Test

contract AaveV3LlamaProposal_20230803Test is Test {
  IERC20 public constant AUSDC = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN);
  IERC20 public constant AAVE = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING);

  // 0x464
  ICollector public immutable AAVE_COLLECTOR = AaveV2Ethereum.COLLECTOR;
  address public constant ECOSYSTEM_RESERVE = 0x25F2226B597E8F9514B3F68F00f494cF4f286491;

  address public constant LLAMA_RECIPIENT = 0xb428C6812E53F843185986472bb7c1E25632e0f7;

  IStreamable public immutable STREAMABLE_AAVE_COLLECTOR =
    IStreamable(address(AaveV2Ethereum.COLLECTOR));
  
  // IStreamable public immutable STREAMABLE_ER =
  //   IStreamable(address(AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER));

  uint256 public constant AAVE_STREAM_AMOUNT = 283230000000000000000;
  uint256 public constant AUSDC_STREAM_AMOUNT = 546596100000;
  uint256 public constant STREAM_DURATION = 57 days;
  uint256 public constant ACTUAL_AMOUNT_AUSDC = (AUSDC_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;
  uint256 public constant ACTUAL_AMOUNT_AAVE = (AAVE_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;


  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17839863);
  }

  // Full Vesting Test
  function testExecute() public {
    // Capturing next Stream IDs before proposal is executed
    uint256 nextCollectorStreamID = STREAMABLE_AAVE_COLLECTOR.getNextStreamId();
    uint256 INITIAL_LLAMA_AUSDC_BALANCE = AUSDC.balanceOf(LLAMA_RECIPIENT);
    // uint256 nextEcosystemStreamID = ECOSYSTEM_RESERVE.getNextStreamId();
    // uint256 initialLLAMAAaveBalance = AAVE.balanceOf(LLAMA_RECIPIENT);

    // execute proposal
    GovHelpers.executePayload(
      vm,
      address(new AaveV3LlamaProposal_20230803()),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    // Checking if the streams have been created properly
    // scoping to avoid the "stack too deep" error
    // USDC test expected to fail because there's no USDC left on the collector
    {
      (
        address senderUSDC,
        address recipientUSDC,
        uint256 depositUSDC,
        address tokenAddressUSDC,
        uint256 startTimeUSDC,
        uint256 stopTimeUSDC,
        uint256 remainingBalanceUSDC,

      ) = STREAMABLE_AAVE_COLLECTOR.getStream(nextCollectorStreamID);

      // (
      //   address senderAAVE,
      //   address recipientAAVE,
      //   uint256 depositAAVE,
      //   address tokenAddressAAVE,
      //   uint256 startTimeAAVE,
      //   uint256 stopTimeAAVE,
      //   uint256 remainingBalanceAAVE,

      // ) = AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.getStream(nextEcosystemStreamID);

      assertEq(senderUSDC, address(AAVE_COLLECTOR));
      assertEq(recipientUSDC, LLAMA_RECIPIENT);
      assertEq(depositUSDC, ACTUAL_AMOUNT_AUSDC);
      assertEq(tokenAddressUSDC, address(AUSDC));
      assertEq(stopTimeUSDC - startTimeUSDC, STREAM_DURATION);
      assertEq(remainingBalanceUSDC, ACTUAL_AMOUNT_AUSDC);

    //   assertEq(senderAAVE, address(AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER));
    //   assertEq(recipientAAVE, LLAMA_RECIPIENT);
    //   assertEq(depositAAVE, ACTUAL_AMOUNT_AAVE);
    //   assertEq(tokenAddressAAVE, address(AAVE));
    //   assertEq(stopTimeAAVE - startTimeAAVE, STREAM_DURATION);
    //   assertEq(remainingBalanceAAVE, ACTUAL_AMOUNT_AAVE);
    // }

    // Checking if LLAMA can withdraw from streams

    vm.startPrank(LLAMA_RECIPIENT);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);

    // STREAMABLE_ER.withdrawFromStream(nextEcosystemStreamID, ACTUAL_AMOUNT_AAVE);
    // uint256 nextLLAMAAaveBalance = AAVE.balanceOf(LLAMA_RECIPIENT);
    // assertEq(initialLLAMAAaveBalance, nextLLAMAAaveBalance - ACTUAL_AMOUNT_AAVE);

    STREAMABLE_AAVE_COLLECTOR.withdrawFromStream(nextCollectorStreamID, ACTUAL_AMOUNT_AUSDC);
    uint256 nextLLAMAUSDCBalance = AUSDC.balanceOf(LLAMA_RECIPIENT);

    // this fails

    assertEq(INITIAL_LLAMA_AUSDC_BALANCE, nextLLAMAUSDCBalance - ACTUAL_AMOUNT_AUSDC);
    
    vm.stopPrank();
  }
}
}
