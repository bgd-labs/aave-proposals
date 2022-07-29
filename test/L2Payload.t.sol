// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import 'forge-std/console.sol';
import {Test} from 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';


import {L2Payload} from '../src/contracts/L2Payload.sol';
import {IStateReceiver} from '../src/interfaces/FxChild.sol';
import {Deploy} from '../script/Deploy.s.sol';

contract L2PayloadTest is Test {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 l2Fork;
  L2Payload public l2payload;
  Deploy deploy;
  address public constant BRIDGE_ADMIN = 0x0000000000000000000000000000000000001001;

  function setUp() public {
    l2Fork = vm.createSelectFork('https://polygon-rpc.com', 31237525);
    mainnetFork = vm.createSelectFork('https://rpc.flashbots.net/', 15231241);
    deploy = new Deploy();
  }

  function testProposal() public {
    // deploy l2 payload
    vm.selectFork(l2Fork);
    l2payload = new L2Payload();

    // depoly l1 proposal
    vm.selectFork(mainnetFork);
    // TODO: there's seems to be an issue with foundry when I do a `vm.startPrank(AAVE_WHALE);` here
    // instead of in scripts it will fail
    uint256 proposalId = deploy.createL1Proposal(address(l2payload));
    vm.stopPrank();

    // execute & bridge the payload
    vm.recordLogs();
    GovHelpers.passVoteAndExecute(vm, proposalId);

    // the execution will yield multiple events, we search the StateSynced one for mocking the bridging
    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(keccak256('StateSynced(uint256,address,bytes)'), entries[2].topics[0]);
    console.log(uint256(entries[2].topics[1]));
    console.log(address(uint160(uint256(entries[2].topics[2]))));
    assertEq(address(uint160(uint256(entries[2].topics[2]))), deploy.FX_CHILD_ADDRESS());

    vm.selectFork(l2Fork);
    vm.stopPrank();
    vm.startPrank(BRIDGE_ADMIN);
    // mock bridge execution
    IStateReceiver(deploy.FX_CHILD_ADDRESS()).onStateReceive(
      uint256(entries[2].topics[1]),
      abi.encode(
        address(GovHelpers.SHORT_EXECUTOR),
        entries[2].data
      )
    );
  }
}
