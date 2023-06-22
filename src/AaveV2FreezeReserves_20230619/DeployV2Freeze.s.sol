// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2FreezeReserves_20230619} from 'src/AaveV2FreezeReserves_20230619/AaveV2FreezeReserves_20230619.sol';

contract DeployPayload is EthereumScript {
  function run() external broadcast {
    new AaveV2FreezeReserves_20230619();
  }
}

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // TODO: Replace by actual payload
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2FreezeReserves_20230619/V2-to-V3-MIGRATION-NEXT-STEPS.md'
      )
    );
  }
}
