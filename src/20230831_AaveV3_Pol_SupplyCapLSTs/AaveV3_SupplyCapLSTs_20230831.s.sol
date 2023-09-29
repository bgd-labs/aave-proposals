// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Polygon_SupplyCapLSTs_20230831} from './AaveV3_Polygon_SupplyCapLSTs_20230831.sol';

/**
 * @dev Deploy AaveV3_Polygon_SupplyCapLSTs_20230831
 * command: make deploy-ledger contract=src/20230831_AaveV3_Pol_SupplyCapLSTs/AaveV3_SupplyCapLSTs_20230831.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Polygon_SupplyCapLSTs_20230831();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230831_AaveV3_Pol_SupplyCapLSTs/AaveV3_SupplyCapLSTs_20230831.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230831_AaveV3_Pol_SupplyCapLSTs/SupplyCapLSTs.md')
    );
  }
}