// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2EthBUSDIR_20230602} from 'src/AaveV2EthBUSDIR_20230602/AaveV2EthBUSDIR_20230602.sol';

contract DeployMainnetBUSDPayload is EthereumScript {
  function run() external broadcast {
    new AaveV2EthBUSDIR_20230602();
  }
}

contract BUSDPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // TODO: Replace by actual payload
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2EthBUSDIR_20230602/BUSD-OFFBOARDING-PLAN-PART-II-AIP.md',
        // if you set `upload` to `true`, your env must contain PINATA_KEY & PINATA_SECRET
        // the file will be uploaded automatically once merged to main
        false
      )
    );
  }
}
