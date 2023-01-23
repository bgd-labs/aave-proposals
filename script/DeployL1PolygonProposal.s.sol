// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

library DeployL1PolygonProposal {
  function _deployL1Proposal(address payload, bytes32 ipfsHash)
    internal
    returns (uint256 proposalId)
  {
    require(payload != address(0), "ERROR: L2_PAYLOAD can't be address(0)");
    require(ipfsHash != bytes32(0), "ERROR: IPFS_HASH can't be bytes32(0)");
    address[] memory targets = new address[](1);
    targets[0] = AaveGovernanceV2.CROSSCHAIN_FORWARDER_POLYGON;
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

contract DeployMai is Script {
  function run() external {
    vm.startBroadcast();
    DeployL1PolygonProposal._deployL1Proposal(
      0x83Fba23163662149B33DBC05cF1312DF6dcBA72b,
      0xf6e50d5a3f824f5ab4ffa15fb79f4fa1871b8bf7af9e9b32c1aaaa9ea633006d
    );
    vm.stopBroadcast();
  }
}

contract DeployFrax is Script {
  function run() external {
    vm.startBroadcast();
    DeployL1PolygonProposal._deployL1Proposal(
      0xA2f3F9534E918554A9e95cfa7dC4F763d02A0859,
      bytes32(0) // TODO: replace with actual ipfshash
    );
    vm.stopBroadcast();
  }
}

contract DeployAGEURFreeze is Script {
  function run() external {
    vm.startBroadcast();
    DeployL1PolygonProposal._deployL1Proposal(
      0x7b8Fa4540246554e77FCFf140f9114de00F8bB8D,
      0xafa8d52094cc041ee20ca429e22b86ae20d6735b4067a617548ccc242bd5b264
    );
    vm.stopBroadcast();
  }
}

contract DeployJEURFreeze is Script {
  function run() external {
    vm.startBroadcast();
    DeployL1PolygonProposal._deployL1Proposal(
      0x165e90Bd0a41d08fA1891CcDCEe315D7b83B3419,
      0x0baa1d8fa1dbcd7a15276f668b234f9847ba2848f9aa6a4b79eaa6d927b92b8e
    );
    vm.stopBroadcast();
  }
}
