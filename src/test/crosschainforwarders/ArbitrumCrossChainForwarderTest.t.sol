// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Arbitrum, AaveMisc} from 'aave-address-book/AaveAddressBook.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {BridgeExecutorHelpers} from 'aave-helpers/BridgeExecutorHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
import {IInbox} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/interfaces/IInbox.sol';
import {IL2BridgeExecutor} from 'governance-crosschain-bridges/contracts/interfaces/IL2BridgeExecutor.sol';
import {CrosschainForwarderArbitrum} from '../../lib/crosschainforwarders/CrosschainForwarderArbitrum.sol';
import {AaveV3ArbWSTETHListingPayload} from '../../contracts/arbitrum/AaveV3ArbWSTETHListingPayload.sol';

/**
 * This test covers syncing between mainnet and arbitrum.
 */
contract ArbitrumCrossChainForwarderTest is ProtocolV3TestBase {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 arbitrumFork;

  AaveV3ArbWSTETHListingPayload public wstEthPayload;

  IInbox public constant INBOX = IInbox(0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f);

  address public constant ARBITRUM_BRIDGE_EXECUTOR = AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR;

  address public constant DAI = 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1;

  uint256 public constant MESSAGE_LENGTH = 580;

  CrosschainForwarderArbitrum public forwarder =
    CrosschainForwarderArbitrum(AaveGovernanceV2.CROSSCHAIN_FORWARDER_ARBITRUM);

  function setUp() public {
    mainnetFork = vm.createFork(vm.rpcUrl('mainnet'), 16128510);
    arbitrumFork = vm.createFork(vm.rpcUrl('arbitrum'), 62456736);
  }

  // utility to transform memory to calldata so array range access is available
  function _cutBytes(bytes calldata input) public pure returns (bytes calldata) {
    return input[64:];
  }

  function testHasSufficientGas() public {
    vm.selectFork(mainnetFork);
    assertEq(AaveGovernanceV2.SHORT_EXECUTOR.balance, 0);
    assertEq(forwarder.hasSufficientGasForExecution(580), false);
    deal(address(AaveGovernanceV2.SHORT_EXECUTOR), 0.001 ether);
    assertEq(forwarder.hasSufficientGasForExecution(580), true);
  }

  function testgetRequiredGas() public {
    vm.selectFork(mainnetFork);
    assertGt(forwarder.getRequiredGas(580), 0);
  }

  function testProposalE2E() public {
    // assumes the short exec will be topped up with some eth to pay for l2 fee
    vm.selectFork(mainnetFork);
    deal(address(AaveGovernanceV2.SHORT_EXECUTOR), 0.001 ether);

    vm.selectFork(arbitrumFork);
    // we get all configs to later on check that payload only changes stEth
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Arbitrum.POOL);
    // 1. deploy l2 payload
    wstEthPayload = new AaveV3ArbWSTETHListingPayload();

    // 2. create l1 proposal
    vm.selectFork(mainnetFork);
    vm.startPrank(AaveMisc.ECOSYSTEM_RESERVE);
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildArbitrum(address(wstEthPayload));

    uint256 proposalId = GovHelpers.createProposal(
      payloads,
      0xec9d2289ab7db9bfbf2b0f2dd41ccdc0a4003e9e0d09e40dee09095145c63fb5
    );
    vm.stopPrank();

    // 3. execute proposal and record logs so we can extract the emitted StateSynced event
    vm.recordLogs();
    bytes memory payload = forwarder.getEncodedPayload(address(wstEthPayload));

    // check ticket is created correctly
    vm.expectCall(
      address(INBOX),
      abi.encodeCall(
        IInbox.unsafeCreateRetryableTicket,
        (
          ARBITRUM_BRIDGE_EXECUTOR,
          0,
          forwarder.getRequiredGas(payload.length),
          forwarder.ARBITRUM_BRIDGE_EXECUTOR(),
          forwarder.ARBITRUM_GUARDIAN(),
          0,
          0,
          payload
        )
      )
    );
    GovHelpers.passVoteAndExecute(vm, proposalId);

    // check events are emitted correctly
    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(keccak256('InboxMessageDelivered(uint256,bytes)'), entries[3].topics[0]);
    // uint256 messageId = uint256(entries[3].topics[1]);
    (
      address to,
      uint256 callvalue,
      uint256 value,
      uint256 maxSubmissionCost,
      address excessFeeRefundAddress,
      address callValueRefundAddress,
      uint256 maxGas,
      uint256 gasPriceBid,
      uint256 length
    ) = abi.decode(
        this._cutBytes(entries[3].data),
        (address, uint256, uint256, uint256, address, address, uint256, uint256, uint256)
      );
    assertEq(callvalue, 0);
    assertEq(value > 0, true);
    assertEq(maxSubmissionCost > 0, true);
    assertEq(to, ARBITRUM_BRIDGE_EXECUTOR);
    assertEq(excessFeeRefundAddress, ARBITRUM_BRIDGE_EXECUTOR);
    assertEq(callValueRefundAddress, forwarder.ARBITRUM_GUARDIAN());
    assertEq(gasPriceBid, 0);
    assertEq(maxGas, 0);
    assertEq(length, 580);

    // 4. mock the queuing on l2 with the data emitted on InboxMessageDelivered
    vm.selectFork(arbitrumFork);
    vm.startPrank(AddressAliasHelper.applyL1ToL2Alias(AaveGovernanceV2.SHORT_EXECUTOR));
    ARBITRUM_BRIDGE_EXECUTOR.call(payload);
    vm.stopPrank();
    // 5. execute proposal on l2
    IL2BridgeExecutor bridgeExecutor = IL2BridgeExecutor(ARBITRUM_BRIDGE_EXECUTOR);
    vm.warp(block.timestamp + bridgeExecutor.getDelay() + 1);
    // execute the proposal
    bridgeExecutor.execute(bridgeExecutor.getActionsSetCount() - 1);

    // not yep applicable as we don't have any propoer payload
    // // 6. verify results
    // ReserveConfig[] memory allConfigsAfter = AaveV3Helpers._getReservesConfigs(
    //   false
    // );
    // ReserveConfig memory expectedAssetConfig = ReserveConfig({
    //   symbol: 'OP',
    //   underlying: OP,
    //   aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
    //   variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
    //   stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
    //   decimals: 18,
    //   ltv: 3000,
    //   liquidationThreshold: 5000,
    //   liquidationBonus: 11200,
    //   liquidationProtocolFee: 1000,
    //   reserveFactor: 3000,
    //   usageAsCollateralEnabled: true,
    //   borrowingEnabled: true,
    //   interestRateStrategy: AaveV3Helpers
    //     ._findReserveConfig(allConfigsAfter, 'WETH', false)
    //     .interestRateStrategy,
    //   stableBorrowRateEnabled: false,
    //   isActive: true,
    //   isFrozen: false,
    //   isSiloed: false,
    //   supplyCap: 1_000_000,
    //   borrowCap: 0,
    //   debtCeiling: 0,
    //   eModeCategory: 0
    // });
    // AaveV3Helpers._validateReserveConfig(expectedAssetConfig, allConfigsAfter);
    // AaveV3Helpers._noReservesConfigsChangesApartNewListings(
    //   allConfigsBefore,
    //   allConfigsAfter
    // );
    // AaveV3Helpers._validateReserveTokensImpls(
    //   vm,
    //   AaveV3Helpers._findReserveConfig(allConfigsAfter, 'OP', false),
    //   ReserveTokens({
    //     aToken: stEthPayload.ATOKEN_IMPL(),
    //     stableDebtToken: stEthPayload.SDTOKEN_IMPL(),
    //     variableDebtToken: stEthPayload.VDTOKEN_IMPL()
    //   })
    // );
    // AaveV3Helpers._validateAssetSourceOnOracle(OP, stEthPayload.PRICE_FEED());
    // // impl should be same as USDC
    // AaveV3Helpers._validateReserveTokensImpls(
    //   vm,
    //   AaveV3Helpers._findReserveConfig(allConfigsAfter, 'USDC', false),
    //   ReserveTokens({
    //     aToken: stEthPayload.ATOKEN_IMPL(),
    //     stableDebtToken: stEthPayload.SDTOKEN_IMPL(),
    //     variableDebtToken: stEthPayload.VDTOKEN_IMPL()
    //   })
    // );
    // _validatePoolActionsPostListing(allConfigsAfter);
  }

  // function _validatePoolActionsPostListing(
  //   ReserveConfig[] memory allReservesConfigs
  // ) internal {
  //   address aOP = AaveV3Helpers
  //     ._findReserveConfig(allReservesConfigs, 'OP', false)
  //     .aToken;
  //   address vOP = AaveV3Helpers
  //     ._findReserveConfig(allReservesConfigs, 'OP', false)
  //     .variableDebtToken;
  //   address sOP = AaveV3Helpers
  //     ._findReserveConfig(allReservesConfigs, 'OP', false)
  //     .stableDebtToken;
  //   address vDAI = AaveV3Helpers
  //     ._findReserveConfig(allReservesConfigs, 'DAI', false)
  //     .variableDebtToken;

  //   AaveV3Helpers._deposit(vm, OP_WHALE, OP_WHALE, OP, 1000 ether, true, aOP);

  //   vm.startPrank(DAI_WHALE);
  //   IERC20(DAI).transfer(OP_WHALE, 1000 ether);
  //   vm.stopPrank();

  //   AaveV3Helpers._borrow(vm, OP_WHALE, OP_WHALE, DAI, 222 ether, 2, vDAI);

  //   // Not possible to borrow and repay when vdebt index doesn't changing, so moving 1s
  //   skip(1);

  //   AaveV3Helpers._repay(
  //     vm,
  //     OP_WHALE,
  //     OP_WHALE,
  //     DAI,
  //     IERC20(DAI).balanceOf(OP_WHALE),
  //     2,
  //     vDAI,
  //     true
  //   );

  //   AaveV3Helpers._withdraw(vm, OP_WHALE, OP_WHALE, OP, type(uint256).max, aOP);
  // }
}
