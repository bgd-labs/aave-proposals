// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveAddressBook.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {BridgeExecutorHelpers} from 'aave-helpers/BridgeExecutorHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
import {IInbox} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/interfaces/IInbox.sol';
import {IL2BridgeExecutor} from 'governance-crosschain-bridges/contracts/interfaces/IL2BridgeExecutor.sol';
import {CrosschainForwarderArbitrum} from '../../contracts/arbitrum/CrosschainForwarderArbitrum.sol';
import {AaveV3ArbCapsPayload} from '../../contracts/arbitrum/AaveV3ArbCapsPayload.sol';
import {DeployL1ArbitrumProposal} from '../../../script/DeployL1ArbitrumProposal.s.sol';

contract AaveV3ArbCapsPayloadTest is ProtocolV3TestBase {
  using stdStorage for StdStorage;
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 arbitrumFork;

  //   address public constant payloadAdress =
  //     0xC9df68EdcB0c8fb7Ced82e5836b75c002c723e17;
  //   AaveV3ArbCapsPayload public proposalPayload =
  //     AaveV3ArbCapsPayload(payloadAdress);
  AaveV3ArbCapsPayload public proposalPayload;

  bytes32 ipfs =
    0x7ecafb3b0b7e418336cccb0c82b3e25944011bf11e41f8dc541841da073fe4f1; //TODO - change to new ipfs

  address public constant ARBITRUM_BRIDGE_EXECUTOR =
    0x7d9103572bE58FfE99dc390E8246f02dcAe6f611;
  CrosschainForwarderArbitrum public forwarder;

  IInbox public constant INBOX =
    IInbox(0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f);

  address public constant WETH = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
  address public constant WBTC = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f;
  address public constant LINK = 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;
  address public constant AAVE = 0xba5DdD1f9d7F570dc94a51479a000E3BCE967196;

  //20.3K WETH
  uint256 public constant WETH_CAP = 20_300;
  //2.1K WBTC
  uint256 public constant WBTC_CAP = 2_100;
  //350K LINK
  uint256 public constant LINK_CAP = 350_000;
  //2.5K AAVE
  uint256 public constant AAVE_CAP = 2_500;

  function setUp() public {
    mainnetFork = vm.createSelectFork(vm.rpcUrl('ethereum'), 16103664);
    forwarder = new CrosschainForwarderArbitrum();

    arbitrumFork = vm.createSelectFork(vm.rpcUrl('arbitrum'), 43236349);

    // fake permission transfer from guardian to ARBITRUM_BRIDGE_EXECUTOR
    vm.selectFork(arbitrumFork);
    vm.startPrank(AaveV3Arbitrum.ACL_ADMIN);
    AaveV3Arbitrum.ACL_MANAGER.addPoolAdmin(ARBITRUM_BRIDGE_EXECUTOR);
    AaveV3Arbitrum.ACL_MANAGER.addRiskAdmin(ARBITRUM_BRIDGE_EXECUTOR);
    vm.stopPrank();
  }

  function testProposalE2E() public {
    // assumes the short exec will be topped up with some eth to pay for l2 fee
    vm.selectFork(mainnetFork);
    deal(address(GovHelpers.SHORT_EXECUTOR), 0.001 ether);

    vm.selectFork(arbitrumFork);
    // we get all configs to later on check that payload only changes stEth
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Arbitrum.POOL
    );

    // 1. deploy l2 payload
    proposalPayload = new AaveV3ArbCapsPayload();

    // 2. create l1 proposal
    vm.selectFork(mainnetFork);
    vm.startPrank(GovHelpers.AAVE_WHALE);
    uint256 proposalId = DeployL1ArbitrumProposal._deployL1Proposal(
      address(proposalPayload),
      ipfs,
      address(forwarder)
    );
    vm.stopPrank();

    // 3. execute proposal and record logs so we can extract the emitted StateSynced event
    vm.recordLogs();
    bytes memory payload = forwarder.getEncodedPayload(
      address(proposalPayload)
    );

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
    assertEq(
      keccak256('InboxMessageDelivered(uint256,bytes)'),
      entries[3].topics[0]
    );

    // 4. mock the queuing on l2 with the data emitted on InboxMessageDelivered
    vm.selectFork(arbitrumFork);
    vm.startPrank(
      AddressAliasHelper.applyL1ToL2Alias(GovHelpers.SHORT_EXECUTOR)
    );
    vm.stopPrank();
    // 5. execute proposal on l2
    IL2BridgeExecutor bridgeExecutor = IL2BridgeExecutor(
      ARBITRUM_BRIDGE_EXECUTOR
    );
    vm.warp(block.timestamp + bridgeExecutor.getDelay() + 1);
    // execute the proposal
    bridgeExecutor.execute(bridgeExecutor.getActionsSetCount() - 1);

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase
      ._getReservesConfigs(AaveV3Arbitrum.POOL);

    //LINK
    ReserveConfig memory LinkConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      LINK
    );
    LinkConfig.supplyCap = LINK_CAP;
    ProtocolV3TestBase._validateReserveConfig(LinkConfig, allConfigsAfter);

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      WETH
    );
    WETHConfig.supplyCap = WETH_CAP;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      WBTC
    );
    WBTCConfig.supplyCap = WBTC_CAP;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);

    //AAVE
    ReserveConfig memory AAVEConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AAVE
    );
    AAVEConfig.supplyCap = AAVE_CAP;
    ProtocolV3TestBase._validateReserveConfig(AAVEConfig, allConfigsAfter);
  }

  // utility to transform memory to calldata so array range access is available
  function _cutBytes(bytes calldata input)
    public
    pure
    returns (bytes calldata)
  {
    return input[64:];
  }
}
