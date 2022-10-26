// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {Test} from 'forge-std/Test.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

library DeployL1OptimismProposal {
  address internal constant CROSSCHAIN_FORWARDER_OPTIMISM =
    0x5f5C02875a8e9B5A26fbd09040ABCfDeb2AA6711;

  function _deployL1Proposal(address payload, bytes32 ipfsHash)
    internal
    returns (uint256 proposalId)
  {
    require(payload != address(0), "ERROR: L2_PAYLOAD can't be address(0)");
    require(ipfsHash != bytes32(0), "ERROR: IPFS_HASH can't be bytes32(0)");
    bytes memory callData = DeployL1OptimismProposalEmitCallData
      ._deployL1Proposal(payload, ipfsHash);
    (bool success, bytes memory response) = address(AaveGovernanceV2.GOV).call(
      callData
    );
    require(success);
    return abi.decode(response, (uint256));
  }
}

library DeployL1OptimismProposalEmitCallData {
  address internal constant CROSSCHAIN_FORWARDER_OPTIMISM =
    0x5f5C02875a8e9B5A26fbd09040ABCfDeb2AA6711;

  function _deployL1Proposal(address payload, bytes32 ipfsHash)
    internal
    pure
    returns (bytes memory callData)
  {
    require(payload != address(0), "ERROR: L2_PAYLOAD can't be address(0)");
    require(ipfsHash != bytes32(0), "ERROR: IPFS_HASH can't be bytes32(0)");
    address[] memory targets = new address[](1);
    targets[0] = CROSSCHAIN_FORWARDER_OPTIMISM;
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute(address)';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = abi.encode(payload);
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;
    return
      abi.encodeWithSelector(
        AaveGovernanceV2.GOV.create.selector,
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

contract DeployOp is Script {
  function run() external {
    vm.startBroadcast();
    DeployL1OptimismProposal._deployL1Proposal(
      0x5f5C02875a8e9B5A26fbd09040ABCfDeb2AA6711,
      0x7ecafb3b0b7e418336cccb0c82b3e25944011bf11e41f8dc541841da073fe4f1
    );
    vm.stopBroadcast();
  }
}

contract EmitOp is Script, Test {
  function run() external {
    bytes memory callData = DeployL1OptimismProposalEmitCallData
      ._deployL1Proposal(
        0x5f5C02875a8e9B5A26fbd09040ABCfDeb2AA6711,
        0x7ecafb3b0b7e418336cccb0c82b3e25944011bf11e41f8dc541841da073fe4f1
      );
    emit log_bytes(callData);
  }
}
