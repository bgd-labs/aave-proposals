// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Pol_CapsUpdates_20231107_Payload} from './AaveV3_Pol_CapsUpdates_20231107_Payload.sol';

/**
 * @dev Deploy AaveV3_Pol_CapsUpdates_20231107
 * command: make deploy-ledger contract=src/AaveV3_Pol_CapsUpdates_20231107/AaveV3_Pol_CapsUpdates_20231107.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Pol_CapsUpdates_20231107_Payload();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Pol_CapsUpdates_20231107/AaveV3_Pol_CapsUpdates_20231107.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Pol_CapsUpdates_20231107/CapsUpdates.md')
    );
  }
}
