// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

contract DeployL1PolygonProposal is Script {
  address internal constant CROSSCHAIN_FORWARDER_POLYGON =
    address(0x158a6bC04F0828318821baE797f50B0A1299d45b);

  function run() external {
    address L2_PAYLOAD_ADDRESS = vm.envAddress('L2_PAYLOAD_ADDRESS');
    bytes32 IPFS_HASH = vm.envBytes32('IPFS_HASH');
    require(
      L2_PAYLOAD_ADDRESS != address(0),
      "ERROR: L2_PAYLOAD can't be address(0)"
    );
    require(IPFS_HASH != bytes32(0), "ERROR: IPFS_HASH can't be bytes32(0)");

    vm.startBroadcast();
    address[] memory targets = new address[](1);
    targets[0] = CROSSCHAIN_FORWARDER_POLYGON;
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute(address)';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = abi.encode(L2_PAYLOAD_ADDRESS);
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;
    AaveGovernanceV2.GOV.create(
      IExecutorWithTimelock(AaveGovernanceV2.SHORT_EXECUTOR),
      targets,
      values,
      signatures,
      calldatas,
      withDelegatecalls,
      IPFS_HASH
    );
    vm.stopBroadcast();
  }
}
