// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {AvalancheScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveAvalancheTreasuryMigration_20230903} from './AaveAvalancheTreasuryMigration_20230903.sol';

/**
 * @dev Deploy AaveAvalancheTreasuryMigration_20230903
 * command: make deploy-ledger contract=src/AaveAvalancheTreasuryMigration_20230903/DeployTreasuryMigration.s.sol:DeployAvalancheV2TreasuryMigrationPayload chain=avalanche
 */
contract DeployAvalancheV2TreasuryMigrationPayload is AvalancheScript {
  function run() external broadcast {
    new AaveAvalancheTreasuryMigration_20230903();
  }
}
