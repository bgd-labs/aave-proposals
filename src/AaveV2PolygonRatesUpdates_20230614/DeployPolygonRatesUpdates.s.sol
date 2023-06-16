// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2PolygonRatesUpdates_20230614} from 'src/AaveV2PolygonRatesUpdates_20230614/AaveV2PolygonRatesUpdates_20230614.sol';

contract DeployPolygonV2RatesUpdatesPayload is PolygonScript {
  function run() external broadcast {
    new AaveV2PolygonRatesUpdates_20230614();
  }
}

contract PolygonV2RatesUpdatesPayloadProposal is PolygonScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(
      0x0cbdB61E8E22cdFA8684935c87b4a8286EC59967
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2PolygonRatesUpdates_20230614/POLYGON_V2_PARAMETER_UPDATES.md'
      )
    );
  }
}
