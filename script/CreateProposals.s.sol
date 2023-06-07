// SPDX-License-Identifier: MIT
// ################ EXAMPLE ################
// PLEASE COPY THE FILE & ADJUST ACCORDINGLY
//    WE WILL REMOVE SCRIPTS PERIODICALLY
// #########################################
pragma solidity ^0.8.0;
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

// Example proposal creation script for a single payload
contract SinglePayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0xd91d1331db4F436DaF47Ec9Dd86deCb8EEF946B4 // deployed cbETH payload
    );
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/script/example-aip.md'));
  }
}

// Example proposal creation script for a single payload emitting the creation calldata
contract SafeSinglePayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0xd91d1331db4F436DaF47Ec9Dd86deCb8EEF946B4 // deployed cbETH payload
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/script/example-aip.md'),
      true
    );
  }
}

// Example proposal creation script for a multiple payloads payload
contract MultiPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(
      0xd91d1331db4F436DaF47Ec9Dd86deCb8EEF946B4 // deployed cbETH payload
    );
    payloads[1] = GovHelpers.buildPolygon(
      0xd91d1331db4F436DaF47Ec9Dd86deCb8EEF946B4 // deployed cbETH payload
    );
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/script/example-aip.md'));
  }
}
