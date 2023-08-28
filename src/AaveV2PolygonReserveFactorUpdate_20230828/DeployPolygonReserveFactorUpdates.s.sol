// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {PolygonScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2PolygonReserveFactorUpdate_20230828} from './AaveV2PolygonReserveFactorUpdate_20230828.sol';

/**
 * @dev Deploy AaveV2PolygonReserveFactorUpdate_20230828
 * command: make deploy-ledger contract=src/AaveV2PolygonReserveFactorUpdate_20230828/DeployPolygonReserveFactorUpdates.s.sol:DeployPolygonV2RatesUpdatesPayload chain=polygon
 */
contract DeployPolygonV2RatesUpdatesPayload is PolygonScript {
  function run() external broadcast {
    new AaveV2PolygonReserveFactorUpdate_20230828();
  }
}

/**
 * @dev Propose AaveV2PolygonReserveFactorUpdate_20230828
 * command: make deploy-ledger contract=src/AaveV2PolygonReserveFactorUpdate_20230828/DeployPolygonReserveFactorUpdates.s.sol:PolygonV2RatesUpdatesPayloadProposal chain=mainnet
 */
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
        'src/AaveV2PolygonReserveFactorUpdate_20230828/UPDATE_RESERVE_FACTORS_POLYGON_V2.md'
      )
    );
  }
}
