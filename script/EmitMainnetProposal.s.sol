// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {Script} from 'forge-std/Script.sol';
import {Test} from 'forge-std/Test.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

library EmitDeployMutliChainProposals {
  function _deployL1Proposal(
    address[] memory payloads,
    address[] memory targets,
    bytes32 ipfsHash
  ) internal pure returns (bytes memory callData) {
    require(ipfsHash != bytes32(0), "ERROR: IPFS_HASH can't be 0");
    require(targets.length == payloads.length, 'ERROR: array length mismatch');

    uint256[] memory values = new uint256[](payloads.length);
    string[] memory signatures = new string[](payloads.length);
    bytes[] memory calldatas = new bytes[](payloads.length);
    bool[] memory withDelegatecalls = new bool[](payloads.length);
    for (uint256 i = 0; i < payloads.length; i++) {
      require(payloads[i] != address(0), "ERROR: PAYLOAD can't be address(0)");
      require(targets[i] != address(0), "ERROR: target can't be address(0)");
      values[i] = 0;
      signatures[i] = 'execute(address)';
      calldatas[i] = abi.encode(payloads[i]);
      withDelegatecalls[i] = true;
    }

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

contract EmitDeployAllCaps is Script, Test {
  function run() external {
    address[] memory payloads = new address[](2);
    address[] memory targets = new address[](2);

    //Borrow caps payloads:
    payloads[0] = 0x060Bea15AF594FE9e0A243cA632F2C7D1935C70f; // polygon
    targets[0] = AaveGovernanceV2.CROSSCHAIN_FORWARDER_POLYGON;

    payloads[1] = 0x280e404338d9d8e50B11D6677B9C91BA86E0FD22; // arbitrum
    targets[1] = AaveGovernanceV2.CROSSCHAIN_FORWARDER_ARBITRUM;

    bytes memory callData = EmitDeployMutliChainProposals._deployL1Proposal(
      payloads,
      targets,
      0x6398bf1320d1347de159e8e387962ca4478d324c1b0664f7ea9afe2cbafa5e21
    );
    emit log_bytes(callData);
  }
}
