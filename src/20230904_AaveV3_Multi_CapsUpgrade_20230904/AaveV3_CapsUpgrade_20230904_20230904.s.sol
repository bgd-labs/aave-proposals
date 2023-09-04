// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, ArbitrumScript, MetisScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Arbitrum_CapsUpgrade_20230904_20230904} from './AaveV3_Arbitrum_CapsUpgrade_20230904_20230904.sol';
import {AaveV3_Metis_CapsUpgrade_20230904_20230904} from './AaveV3_Metis_CapsUpgrade_20230904_20230904.sol';
import {AaveV3_Polygon_CapsUpgrade_20230904_20230904} from './AaveV3_Polygon_CapsUpgrade_20230904_20230904.sol';

/**
 * @dev Deploy AaveV3_Arbitrum_CapsUpgrade_20230904_20230904
 * command: make deploy-ledger contract=src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_CapsUpgrade_20230904_20230904.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3_Arbitrum_CapsUpgrade_20230904_20230904();
  }
}

/**
 * @dev Deploy AaveV3_Metis_CapsUpgrade_20230904_20230904
 * command: make deploy-ledger contract=src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_CapsUpgrade_20230904_20230904.s.sol:DeployMetis chain=metis
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    new AaveV3_Metis_CapsUpgrade_20230904_20230904();
  }
}

/**
 * @dev Deploy AaveV3_Polygon_CapsUpgrade_20230904_20230904
 * command: make deploy-ledger contract=src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_CapsUpgrade_20230904_20230904.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Polygon_CapsUpgrade_20230904_20230904();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_CapsUpgrade_20230904_20230904.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildArbitrum(address(0));
    payloads[1] = GovHelpers.buildMetis(address(0));
    payloads[2] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230904_AaveV3_Multi_CapsUpgrade_20230904/CapsUpgrade_20230904.md'
      )
    );
  }
}
