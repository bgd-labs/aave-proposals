// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3PolygonSupplyCapStmatic_20230810} from './AaveV3PolygonSupplyCapStmatic_20230810.sol';

/**
 * @dev Deploy AaveV3PolygonSupplyCapStmatic_20230810
 * command: make deploy-ledger contract=src/AaveV3PolygonSupplyCapStmatic_20230810/DeployStmaticSupplyCap.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolygonSupplyCapStmatic_20230810();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3PolygonSupplyCapStmatic_20230810/DeployStmaticSupplyCap.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(
        0xF28E5a2f04B6B74741579DaEE1fc164978D2d646
    );
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV3PolygonSupplyCapStmatic_20230810/STMATIC_SUPPLY_CAP_INCREASE.md'));
  }
}
