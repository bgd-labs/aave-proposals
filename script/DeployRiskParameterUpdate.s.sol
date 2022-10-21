// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {Test} from 'forge-std/Test.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

library DeployL1Proposal {
  address internal constant CROSSCHAIN_FORWARDER_POLYGON =
    address(0x158a6bC04F0828318821baE797f50B0A1299d45b);

  // TODO: replace addresses and ipfs hash with deployed ones onces
  address internal constant POLYGON_V2_PAYLOAD = address(0);
  address internal constant POLYGON_V3_PAYLOAD = address(0);
  bytes32 internal constant IPFS_HASH = bytes32(0);

  function _deployL1Proposal() internal returns (bytes memory) {
    require(
      POLYGON_V2_PAYLOAD != address(0),
      "ERROR: L1_PAYLOAD can't be address(0)"
    );
    require(
      POLYGON_V3_PAYLOAD != address(0),
      "ERROR: L2_PAYLOAD can't be address(0)"
    );
    require(IPFS_HASH != bytes32(0), "ERROR: IPFS_HASH can't be bytes32(0)");
    address[] memory targets = new address[](2);
    targets[0] = CROSSCHAIN_FORWARDER_POLYGON;
    targets[1] = CROSSCHAIN_FORWARDER_POLYGON;

    uint256[] memory values = new uint256[](2);
    values[0] = 0;
    values[1] = 0;

    string[] memory signatures = new string[](2);
    signatures[0] = 'execute(address)';
    signatures[1] = 'execute(address)';

    bytes[] memory calldatas = new bytes[](2);
    calldatas[0] = abi.encode(POLYGON_V2_PAYLOAD);
    calldatas[1] = abi.encode(POLYGON_V3_PAYLOAD);

    bool[] memory withDelegatecalls = new bool[](2);
    withDelegatecalls[0] = true;
    withDelegatecalls[1] = true;

    return
      abi.encodeWithSelector(
        AaveGovernanceV2.GOV.create.selector,
        IExecutorWithTimelock(AaveGovernanceV2.SHORT_EXECUTOR),
        targets,
        values,
        signatures,
        calldatas,
        withDelegatecalls,
        IPFS_HASH
      );

    // return
    //   AaveGovernanceV2.GOV.create(
    //     IExecutorWithTimelock(AaveGovernanceV2.SHORT_EXECUTOR),
    //     targets,
    //     values,
    //     signatures,
    //     calldatas,
    //     withDelegatecalls,
    //     IPFS_HASH
    //   );
  }
}

contract DeployRiskParameterUpdateProposal is Script, Test {
  function run() external {
    bytes memory encodedPayload = DeployL1Proposal._deployL1Proposal();
    emit log_bytes(encodedPayload);

    // vm.startBroadcast();
    // vm.stopBroadcast();
  }
}
