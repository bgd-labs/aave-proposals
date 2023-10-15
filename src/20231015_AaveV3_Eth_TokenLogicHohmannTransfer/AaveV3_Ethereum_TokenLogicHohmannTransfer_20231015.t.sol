// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.16;

// testing libraries
import 'forge-std/Test.sol';

// contract dependencies
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, ICollector} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveMisc, IStreamable} from 'aave-address-book/AaveMisc.sol';
import {AaveV3_Ethereum_TokenLogicHohmannTransfer_20231015} from './AaveV3_Ethereum_TokenLogicHohmannTransfer_20231015.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

// make test-contract filter=AaveV3_Ethereum_TokenLogicHohmannTransfer_20231015

contract AaveV3_Ethereum_TokenLogicHohmannTransfer_20231015Test is Test {
  IERC20 public constant GHO = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING);

  address GHO_WHALE = 0xE831C8903de820137c13681E78A5780afDdf7697;

  ICollector public immutable AAVE_COLLECTOR = AaveV2Ethereum.COLLECTOR;

  IStreamable public immutable STREAMABLE_AAVE_COLLECTOR =
    IStreamable(address(AaveV2Ethereum.COLLECTOR));

  uint256 public constant STREAM_AMOUNT = 15_000 * 1e18;
  uint256 public constant STREAM_DURATION = 90 days;
  uint256 public constant actualAmountGHO = (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  address public constant TOKEN_LOGIC = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18211914);
  }

  function testExecute() public {
    
    // transfer GHO to COLLECTOR

    vm.startPrank(GHO_WHALE);
    GHO.transfer(address(AAVE_COLLECTOR), 15_000 * 1e18);
    vm.stopPrank();

    // Capturing next Stream IDs before proposal is executed
    uint256 nextCollectorStreamID = STREAMABLE_AAVE_COLLECTOR.getNextStreamId();

    // execute proposal
    GovHelpers.executePayload(
      vm,
      address(new AaveV3_Ethereum_TokenLogicHohmannTransfer_20231015()),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    uint256 initialBalance = GHO.balanceOf(TOKEN_LOGIC);

    (
      address senderGHO,
      address recipientGHO,
      uint256 depositGHO,
      address tokenAddressGHO,
      uint256 startTimeGHO,
      uint256 stopTimeGHO,
      uint256 remainingBalanceGHO,
      uint256 rateGHO
    ) = STREAMABLE_AAVE_COLLECTOR.getStream(nextCollectorStreamID);

    assertEq(senderGHO, address(AAVE_COLLECTOR));
    assertEq(recipientGHO, TOKEN_LOGIC);
    assertEq(depositGHO, actualAmountGHO);
    assertEq(tokenAddressGHO, address(GHO));
    assertEq(stopTimeGHO - startTimeGHO, STREAM_DURATION);
    assertEq(remainingBalanceGHO, actualAmountGHO);

    uint256 expectedRateGHO = actualAmountGHO / STREAM_DURATION;
    assertEq(
      rateGHO,
      expectedRateGHO,
      'The rate of GHO streaming does not match the expected rate.'
    );

    // Checking if the recipient can withdraw from streams
    vm.startPrank(TOKEN_LOGIC);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);

    STREAMABLE_AAVE_COLLECTOR.withdrawFromStream(nextCollectorStreamID, actualAmountGHO);
    uint256 nextBalance = GHO.balanceOf(TOKEN_LOGIC);
    assertEq(initialBalance, nextBalance - actualAmountGHO);
  }
}
