// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

contract DeployL1Proposal is Script {
  // TODO: remove
  address public constant AAVE_WHALE =
    address(0x25F2226B597E8F9514B3F68F00f494cF4f286491);

  // TODO: remove bridger param
  function createProposal(address bridger, address l2payload)
    public
    returns (uint256)
  {
    vm.startPrank(AAVE_WHALE);
    address[] memory targets = new address[](1);
    targets[0] = bridger; // the payload address on the sidechain
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute(address)';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = abi.encode(l2payload);
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;
    return
      AaveGovernanceV2.GOV.create(
        IExecutorWithTimelock(AaveGovernanceV2.SHORT_EXECUTOR),
        targets,
        values,
        signatures,
        calldatas,
        withDelegatecalls,
        bytes32(0)
      );
  }

  // function run() external {
  //   vm.startBroadcast();
  //   vm.stopBroadcast();
  // }
}
