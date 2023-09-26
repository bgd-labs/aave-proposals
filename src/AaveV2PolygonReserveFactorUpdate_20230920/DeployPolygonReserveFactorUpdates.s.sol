// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {PolygonScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2PolygonReserveFactorUpdate_20230920} from './AaveV2PolygonReserveFactorUpdate_20230920.sol';

/**
 * @dev Deploy AaveV2PolygonReserveFactorUpdate_20230920
 * command: make deploy-ledger contract=src/AaveV2PolygonReserveFactorUpdate_20230920/DeployPolygonReserveFactorUpdates.s.sol:DeployPolygonV2RatesUpdatesPayload chain=polygon
 */
contract DeployPolygonV2RatesUpdatesPayload is PolygonScript {
  function run() external broadcast {
    new AaveV2PolygonReserveFactorUpdate_20230920();
  }
}

/**
 * @dev Propose AaveV2PolygonReserveFactorUpdate_20230920
 * command: make deploy-ledger contract=src/AaveV2PolygonReserveFactorUpdate_20230920/DeployPolygonReserveFactorUpdates.s.sol:PolygonV2RatesUpdatesPayloadProposal chain=mainnet
 */
contract PolygonV2RatesUpdatesPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(
      0x2120570b9ADD275864830B173BdAF50b0f4e748a
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2PolygonReserveFactorUpdate_20230920/UPDATE_RESERVE_FACTORS_POLYGON_V2.md'
      )
    );
  }
}
