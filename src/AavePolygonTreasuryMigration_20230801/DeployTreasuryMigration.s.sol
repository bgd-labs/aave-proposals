// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {PolygonScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AavePolygonTreasuryMigration_20230801} from './AavePolygonTreasuryMigration_20230801.sol';

contract DeployPolygonV2TreasuryMigrationPayload is PolygonScript {
  function run() external broadcast {
    new AavePolygonTreasuryMigration_20230801();
  }
}

contract PolygonV2RatesUpdatesPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(
      address(0) // TODO
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AavePolygonTreasuryMigration_20230801/MIGRATE_POLYGON_V2_TREASURY_TO_POLYGON_V3.md'
      )
    );
  }
}
