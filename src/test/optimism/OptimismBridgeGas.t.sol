// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {BridgeExecutorHelpers} from 'aave-helpers/BridgeExecutorHelpers.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
import {IL2CrossDomainMessenger} from '../../interfaces/optimism/ICrossDomainMessenger.sol';
import {IExecutorBase} from '../../interfaces/IExecutorBase.sol';
import {CrosschainForwarderOptimism} from '../../contracts/optimism/CrosschainForwarderOptimism.sol';
import {OpPayload} from '../../contracts/optimism/OpPayload.sol';
import {DeployL1OptimismProposal} from '../../../script/DeployL1OptimismProposal.s.sol';

contract OptimismBridgeGasTest is ProtocolV3TestBase {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 optimismFork;

  OpPayload public opPayload;

  address public constant OPTIMISM_BRIDGE_EXECUTOR =
    0x7d9103572bE58FfE99dc390E8246f02dcAe6f611;
  IL2CrossDomainMessenger public OVM_L2_CROSS_DOMAIN_MESSENGER =
    IL2CrossDomainMessenger(0x4200000000000000000000000000000000000007);

  address public constant OP = 0x4200000000000000000000000000000000000042;

  address public constant DAI = 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1;

  address public crosschainForwarderOptimism;

  address public sender;
  bytes public message;
  uint256 public nonce;

  function setUp() public {
    optimismFork = vm.createFork(vm.rpcUrl('optimism'), 22961333);
    mainnetFork = vm.createFork(vm.rpcUrl('ethereum'), 15526675);
    vm.selectFork(optimismFork);
    vm.startPrank(AaveV3Optimism.ACL_ADMIN);
    // -------------
    // Claim pool admin
    // Only needed for the first proposal on any pool. If ACL_ADMIN was previously set it will ignore
    // https://github.com/aave/aave-v3-core/blob/master/contracts/dependencies/openzeppelin/contracts/AccessControl.sol#L207
    // -------------
    AaveV3Optimism.ACL_MANAGER.addPoolAdmin(OPTIMISM_BRIDGE_EXECUTOR);
    AaveV3Optimism.ACL_MANAGER.addRiskAdmin(OPTIMISM_BRIDGE_EXECUTOR);
    vm.stopPrank();
    vm.selectFork(mainnetFork);
    crosschainForwarderOptimism = address(new CrosschainForwarderOptimism());
    // 1. deploy l2 payload
    vm.selectFork(optimismFork);
    opPayload = new OpPayload();
    // 2. create l1 proposal
    vm.selectFork(mainnetFork);
    vm.startPrank(GovHelpers.AAVE_WHALE);
    uint256 proposalId = DeployL1OptimismProposal._deployL1Proposal(
      address(opPayload),
      0xec9d2289ab7db9bfbf2b0f2dd41ccdc0a4003e9e0d09e40dee09095145c63fb5,
      address(crosschainForwarderOptimism)
    );
    vm.stopPrank();
    // 3. execute proposal and record logs so we can extract the emitted StateSynced event
    vm.recordLogs();
    GovHelpers.passVoteAndExecute(vm, proposalId);
    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(
      keccak256('SentMessage(address,address,bytes,uint256,uint256)'),
      entries[3].topics[0]
    );
    assertEq(
      address(uint160(uint256(entries[3].topics[1]))),
      OPTIMISM_BRIDGE_EXECUTOR
    );
    (sender, message, nonce) = abi.decode(
      entries[3].data,
      (address, bytes, uint256)
    );
    vm.selectFork(optimismFork);
    vm.startPrank(0x36BDE71C97B33Cc4729cf772aE268934f7AB70B2); // AddressAliasHelper.applyL1ToL2Alias on L1_CROSS_DOMAIN_MESSENGER_ADDRESS
  }

  function testGasUsage() public {
    OVM_L2_CROSS_DOMAIN_MESSENGER.relayMessage(
      OPTIMISM_BRIDGE_EXECUTOR,
      sender,
      message,
      nonce
    );
  }
}
