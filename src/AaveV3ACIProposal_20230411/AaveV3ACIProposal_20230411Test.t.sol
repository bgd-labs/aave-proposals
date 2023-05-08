// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.16;

// testing libraries
import 'forge-std/Test.sol';

// contract dependencies
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveMisc, IStreamable} from 'aave-address-book/AaveMisc.sol';
import {AaveV3ACIProposal_20230411} from 'src/AaveV3ACIProposal_20230411/AaveV3ACIProposal_20230411.sol';
import {DeployMainnetProposal} from 'script/DeployMainnetProposal.s.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ACIProposal_20230411Test is TestWithExecutor {
  address internal constant ECOSYSTEM_RESERVE = AaveMisc.ECOSYSTEM_RESERVE;

  IERC20 public constant AUSDT = IERC20(0x3Ed3B47Dd13EC9a98b44e6204A523E766B225811);

  // 0x464
  address public immutable AAVE_COLLECTOR = address(AaveV2Ethereum.COLLECTOR);
  address public constant ACI_TREASURY = 0x57ab7ee15cE5ECacB1aB84EE42D5A9d0d8112922;

  IStreamable public immutable STREAMABLE_AAVE_COLLECTOR = IStreamable(address(AaveV2Ethereum.COLLECTOR));

  uint256 public constant STREAM_AMOUNT = 250_000 * 1e6;
  uint256 public constant STREAM_DURATION = 180 days;

  uint256 public constant actualAmountUSDT = (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17026907);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  // Full Vesting Test
  function testExecute() public {
    // Capturing next Stream IDs before proposal is executed
    uint256 nextCollectorStreamID = STREAMABLE_AAVE_COLLECTOR.getNextStreamId();
    uint256 initialACIUSDTBalance = AUSDT.balanceOf(ACI_TREASURY);

    // execute proposal
    _executePayload(address(new AaveV3ACIProposal_20230411()));

    // Checking if the streams have been created properly
    // scoping to avoid the "stack too deep" error
    {
      (
        address senderUSDT,
        address recipientUSDT,
        uint256 depositUSDT,
        address tokenAddressUSDT,
        uint256 startTimeUSDT,
        uint256 stopTimeUSDT,
        uint256 remainingBalanceUSDT,

      ) = STREAMABLE_AAVE_COLLECTOR.getStream(nextCollectorStreamID);

      assertEq(senderUSDT, AAVE_COLLECTOR);
      assertEq(recipientUSDT, ACI_TREASURY);
      assertEq(depositUSDT, actualAmountUSDT);
      assertEq(tokenAddressUSDT, address(AUSDT));
      assertEq(stopTimeUSDT - startTimeUSDT, STREAM_DURATION);
      assertEq(remainingBalanceUSDT, actualAmountUSDT);
    }

    // Checking if ACI can withdraw from streams
    vm.startPrank(ACI_TREASURY);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);
    uint256 currentUSDTStreamBalance = STREAMABLE_AAVE_COLLECTOR.balanceOf(
      nextCollectorStreamID,
      ACI_TREASURY
    );
    console.log('stream USDT balance');
    console.log(currentUSDTStreamBalance);
    console.log('actual amount USDT');
    console.log(actualAmountUSDT);

    STREAMABLE_AAVE_COLLECTOR.withdrawFromStream(nextCollectorStreamID, actualAmountUSDT);
    uint256 nextACIUSDTBalance = AUSDT.balanceOf(ACI_TREASURY);
    assertEq(initialACIUSDTBalance, nextACIUSDTBalance - actualAmountUSDT);
    console.log('ACI aUSDT balance increase');
    console.log((nextACIUSDTBalance - initialACIUSDTBalance) / 10 ** 6);
    vm.stopPrank();
  }
}
