// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.16;

// testing libraries
import 'forge-std/Test.sol';

// contract dependencies
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, ICollector} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveMisc, IStreamable} from 'aave-address-book/AaveMisc.sol';
import {AaveV3_Ethereum_ExpansionOfOrbit_20230925} from './AaveV3_Ethereum_ExpansionOfOrbit_20230925.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

// make test-contract filter=AaveV3_Ethereum_ExpansionOfOrbit_20230925

contract AaveV3_Ethereum_ExpansionOfOrbit_20230925Test is Test {
  IERC20 public constant GHO = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING);

  // 0x464
  ICollector public immutable AAVE_COLLECTOR = AaveV2Ethereum.COLLECTOR;
  address public constant STABLE_LABS = 0x9c489E4efba90A67299C1097a8628e233C33BB7B;

  IStreamable public immutable STREAMABLE_AAVE_COLLECTOR =
    IStreamable(address(AaveV2Ethereum.COLLECTOR));

  uint256 public constant STREAM_AMOUNT = 15_000 * 1e18;
  uint256 public constant STREAM_DURATION = 90 days;

  uint256 public constant actualAmountGHO = (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18211914);
  }

  // Full Vesting Test
  function testExecute() public {
    // Capturing next Stream IDs before proposal is executed
    uint256 nextCollectorStreamID = STREAMABLE_AAVE_COLLECTOR.getNextStreamId();
    uint256 initialSTABLELABGHOBalance = GHO.balanceOf(STABLE_LABS);

    // execute proposal
    GovHelpers.executePayload(
      vm,
      address(new AaveV3_Ethereum_ExpansionOfOrbit_20230925()),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    // Checking if the streams have been created properly
    // scoping to avoid the "stack too deep" error
    {
      (
        address senderGHO,
        address recipientGHO,
        uint256 depositGHO,
        address tokenAddressGHO,
        uint256 startTimeGHO,
        uint256 stopTimeGHO,
        uint256 remainingBalanceGHO,

      ) = STREAMABLE_AAVE_COLLECTOR.getStream(nextCollectorStreamID);

      assertEq(senderGHO, address(AAVE_COLLECTOR));
      assertEq(recipientGHO, STABLE_LABS);
      assertEq(depositGHO, actualAmountGHO);
      assertEq(tokenAddressGHO, address(GHO));
      assertEq(stopTimeGHO - startTimeGHO, STREAM_DURATION);
      assertEq(remainingBalanceGHO, actualAmountGHO);
    }

    // Checking if STABLE_LABS can withdraw from streams
    vm.startPrank(STABLE_LABS);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);

    STREAMABLE_AAVE_COLLECTOR.withdrawFromStream(nextCollectorStreamID, actualAmountGHO);
    uint256 nextSTABLELABGHOBalance = GHO.balanceOf(STABLE_LABS);
    assertEq(initialSTABLELABGHOBalance, nextSTABLELABGHOBalance - actualAmountGHO);
    vm.stopPrank();
  }
}
