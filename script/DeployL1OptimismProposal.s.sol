// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

library DeployL1OptimismProposal {
  // address internal constant CROSSCHAIN_FORWARDER_OPTIMISM =
  //   address(0x158a6bC04F0828318821baE797f50B0A1299d45b);

  function _deployL1Proposal(
    address payload,
    bytes32 ipfsHash,
    address crosschainForwarderOptimism
  ) internal returns (uint256 proposalId) {
    require(payload != address(0), "ERROR: L2_PAYLOAD can't be address(0)");
    require(ipfsHash != bytes32(0), "ERROR: IPFS_HASH can't be bytes32(0)");
    address[] memory targets = new address[](1);
    targets[0] = crosschainForwarderOptimism; // CROSSCHAIN_FORWARDER_OPTIMISM;
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute(address)';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = abi.encode(payload);
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
        ipfsHash
      );
  }
}

// TODO: enter correct addresses
contract DeployOp is Script {
  function run() external {
    vm.startBroadcast();
    DeployL1OptimismProposal._deployL1Proposal(
      0x5f5C02875a8e9B5A26fbd09040ABCfDeb2AA6711,
      bytes32(0),
      address(0)
    );
    vm.stopBroadcast();
  }
}
