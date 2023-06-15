// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2PolygonRatesUpdates_20230614} from 'src/AaveV2PolygonRatesUpdates_20230614/AaveV2PolygonRatesUpdates_20230614.sol';

contract DeployPolygonV2RatesUpdatesPayload is EthereumScript {
  function run() external broadcast {
    new AaveV2PolygonRatesUpdates_20230614();
  }
}

contract PolygonV2RatesUpdatesPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(
      address(0) // TODO: Replace by actual payload
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2PolygonRatesUpdates_20230614/TODO.md',
        // if you set `upload` to `true`, your env must contain PINATA_KEY & PINATA_SECRET
        // the file will be uploaded automatically once merged to main
        true
      )
    );
  }
}
