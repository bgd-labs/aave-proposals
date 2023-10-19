// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019} from './AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019.sol';

/**
 * @dev Deploy AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019
 * command: make deploy-ledger contract=src/20231019_AaveV2_Pol_ReserveFactorUpdateOctober2023/AaveV2_ReserveFactorUpdateOctober2023_20231019.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231019_AaveV2_Pol_ReserveFactorUpdateOctober2023/AaveV2_ReserveFactorUpdateOctober2023_20231019.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(address(0)); // TODO
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231019_AaveV2_Pol_ReserveFactorUpdateOctober2023/ReserveFactorUpdateOctober2023.md'
      )
    );
  }
}
