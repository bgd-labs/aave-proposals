// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {PolygonScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AavePolygonTreasuryMigration_20230801} from './AavePolygonTreasuryMigration_20230801.sol';

/**
 * @dev Deploy AavePolygonTreasuryMigration_20230801
 * command: make deploy-ledger contract=src/AavePolygonTreasuryMigration_20230801/DeployTreasuryMigration.s.sol:DeployPolygonV2TreasuryMigrationPayload chain=polygon
 */
contract DeployPolygonV2TreasuryMigrationPayload is PolygonScript {
  function run() external broadcast {
    new AavePolygonTreasuryMigration_20230801();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AavePolygonTreasuryMigration_20230801/DeployTreasuryMigration.s.sol:PolygonV2RatesUpdatesPayloadProposal chain=mainnet
 */
contract PolygonV2RatesUpdatesPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(
      0xC34A9391c08b64C4A9167D9e1E884B3735Ce21b0
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
