// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Pol_CapsUpdate_20230608} from './AaveV3_Pol_CapsUpdate_20230608.sol';

/**
 * @dev Deploy AaveV3_Pol_CapsUpdate_20230608
 * command: make deploy-ledger contract=src/AaveV3_Pol_CapsUpdate_20230608/AaveV3_Pol_CapsUpdate_20230608.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Pol_CapsUpdate_20230608();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Pol_CapsUpdate_20230608/AaveV3_Pol_CapsUpdate_20230608.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(0x5C748a7Ac5390ee6C9E0511bafd4Ec95183E496a);
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Pol_CapsUpdate_20230608/CapsUpdate.md'));
  }
}
