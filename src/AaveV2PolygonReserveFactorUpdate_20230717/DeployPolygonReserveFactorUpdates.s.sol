// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {PolygonScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2PolygonReserveFactorUpdate_20230717} from './AaveV2PolygonReserveFactorUpdate_20230717.sol';

contract DeployPolygonV2RatesUpdatesPayload is PolygonScript {
  function run() external broadcast {
    new AaveV2PolygonReserveFactorUpdate_20230717();
  }
}

contract PolygonV2RatesUpdatesPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(
      0x812dDad273544754d0672A009C27550899e658Aa
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2PolygonReserveFactorUpdate_20230717/UPDATE_RESERVE_FACTORS_POLYGON_V2.md'
      )
    );
  }
}
