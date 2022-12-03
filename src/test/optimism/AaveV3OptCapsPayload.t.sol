// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {BridgeExecutorHelpers} from 'aave-helpers/BridgeExecutorHelpers.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
import {IL2CrossDomainMessenger} from 'governance-crosschain-bridges/contracts/dependencies/optimism/interfaces/IL2CrossDomainMessenger.sol';
import {CrosschainForwarderOptimism} from '../../contracts/optimism/CrosschainForwarderOptimism.sol';
import {AaveV3OptCapsPayload} from '../../contracts/optimism/AaveV3OptCapsPayload.sol';
import {DeployL1OptimismProposal, DeployL1OptimismProposalEmitCallData} from '../../../script/DeployL1OptimismProposal.s.sol';

contract OptimismOpE2ETest is ProtocolV3TestBase {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 optimismFork;

  bytes32 ipfs =
    0x7ecafb3b0b7e418336cccb0c82b3e25944011bf11e41f8dc541841da073fe4f1;

  address public constant OPTIMISM_BRIDGE_EXECUTOR =
    0x7d9103572bE58FfE99dc390E8246f02dcAe6f611;
  IL2CrossDomainMessenger public OVM_L2_CROSS_DOMAIN_MESSENGER =
    IL2CrossDomainMessenger(0x4200000000000000000000000000000000000007);

  string public constant LinkSymbol = 'LINK';
  string public constant WETHSymbol = 'WETH';
  string public constant WBTCSymbol = 'WBTC';

  //35.9K WETH
  uint256 public constant WETH_CAP = 35_900;
  //1.1K WBTC
  uint256 public constant WBTC_CAP = 1_100;
  //258K LINK
  uint256 public constant LINK_CAP = 258_000;

  //TODO delete?
  address public constant OP = 0x4200000000000000000000000000000000000042;

  address public constant DAI = 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1;

  function setUp() public {
    optimismFork = vm.createFork(vm.rpcUrl('optimism'), 336023);
    mainnetFork = vm.createFork(vm.rpcUrl('ethereum'), 16103164);
  }

  function testEmitOnly() public {
    bytes memory callData = DeployL1OptimismProposalEmitCallData
      ._deployL1Proposal(address(opPayload), ipfs);
    emit log_bytes(callData);
  }

  function testProposalE2E() public {
    vm.selectFork(optimismFork);
    // we get all configs to later on check that payload only changes OP
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Optimism.POOL
    );
    AaveV3OptCapsPayload opPayload = new AaveV3OptCapsPayload();
    // 1. create l1 proposal
    vm.selectFork(mainnetFork);
    vm.startPrank(GovHelpers.AAVE_WHALE);
    uint256 proposalId = DeployL1OptimismProposal._deployL1Proposal(
      address(opPayload),
      ipfs
    );
    vm.stopPrank();
    // 2. execute proposal and record logs so we can extract the emitted StateSynced event
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
    (address sender, bytes memory message, uint256 nonce) = abi.decode(
      entries[3].data,
      (address, bytes, uint256)
    );
    // 3. mock the receive on l2 with the data emitted on StateSynced
    vm.selectFork(optimismFork);
    vm.startPrank(0x36BDE71C97B33Cc4729cf772aE268934f7AB70B2); // AddressAliasHelper.applyL1ToL2Alias on L1_CROSS_DOMAIN_MESSENGER_ADDRESS
    OVM_L2_CROSS_DOMAIN_MESSENGER.relayMessage(
      OPTIMISM_BRIDGE_EXECUTOR,
      sender,
      message,
      nonce
    );
    vm.stopPrank();

    // 4. execute proposal on l2
    BridgeExecutorHelpers.waitAndExecuteLatest(vm, OPTIMISM_BRIDGE_EXECUTOR);

    // 5. verify results
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase
      ._getReservesConfigs(false);

    //LINK
    ReserveConfig memory LinkConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      LinkSymbol,
      false
    );
    LinkConfig.supplyCap = LINK_CAP;
    ProtocolV3TestBase._validateReserveConfig(LinkConfig, allConfigsAfter);

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      WETHSymbol,
      false
    );
    WETHConfig.supplyCap = WETH_CAP;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      WBTCSymbol,
      false
    );
    WBTCConfig.supplyCap = WBTC_CAP;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);
  }
}
