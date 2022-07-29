// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import 'forge-std/console.sol';
import {Test} from 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

import {L2Payload} from '../src/contracts/L2Payload.sol';
import {IStateReceiver} from '../src/interfaces/FxChild.sol';
import {Deploy} from '../script/Deploy.s.sol';

contract GhostTest is Test {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 l2Fork;
  L2Payload public l2payload;
  Deploy deploy;

  function setUp() public {
    l2Fork = vm.createSelectFork('https://polygon-rpc.com', 31237525);
    mainnetFork = vm.createSelectFork('https://rpc.flashbots.net/', 15231241);
    deploy = new Deploy();
  }

  // function testProposalL1() public {
  //   vm.selectFork(mainnetFork);
  //   deploy.createL1Proposal();
  // }

  // function testPayloadL2() public {
  //   vm.selectFork(l2Fork);
  //   ghost.execute();
  // }

  function testFullFlow() public {
    vm.selectFork(l2Fork);
    l2payload = new L2Payload();

    vm.selectFork(mainnetFork);

    uint256 proposalId = deploy.createL1Proposal(address(l2payload));
    vm.stopPrank();

    // execute & bridge the payload
    vm.recordLogs();
    GovHelpers.passVoteAndExecute(vm, proposalId);

    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(keccak256('StateSynced(uint256,address,bytes)'), entries[2].topics[0]);
    console.log(uint256(entries[2].topics[1]));
    console.log(address(uint160(uint256(entries[2].topics[2]))));
    assertEq(address(uint160(uint256(entries[2].topics[2]))), deploy.FX_CHILD_ADDRESS());

    vm.selectFork(l2Fork);
    vm.stopPrank();

    vm.startPrank(deploy.BRIDGE_ADMIN());
    // IStateReceiver(deploy.FX_CHILD_ADDRESS()).onStateReceive(
    //   uint256(entries[2].topics[1]),
    //   abi.encode(
    //     address(GovHelpers.SHORT_EXECUTOR),
    //     address(0xdc9A35B16DB4e126cFeDC41322b3a36454B1F772),
    //     entries[2].data
    //   )
    // );
  }
}
