// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

contract DeployL1Proposal is Script {
  // TODO: BRIDGE_EXECUTOR should be set once deployed
  address internal constant CROSSCHAIN_FORWARDER_POLYGON =
    address(0x158a6bC04F0828318821baE797f50B0A1299d45b);
  address internal constant L2_PAYLOAD = address(0);

  function run() external {
    require(L2_PAYLOAD != address(0), "ERROR: L2_PAYLOAD can't be address(0)");
    vm.startBroadcast();
    address[] memory targets = new address[](1);
    targets[0] = CROSSCHAIN_FORWARDER_POLYGON;
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute(address)';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = abi.encode(L2_PAYLOAD);
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;
    AaveGovernanceV2.GOV.create(
      IExecutorWithTimelock(AaveGovernanceV2.SHORT_EXECUTOR),
      targets,
      values,
      signatures,
      calldatas,
      withDelegatecalls,
      bytes32(0)
    );
    vm.stopBroadcast();
  }
}
