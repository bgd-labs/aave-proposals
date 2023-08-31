// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript, ArbitrumScript, PolygonScript, AvalancheScript, MetisScript, BaseScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829.sol';
import {AaveV3_Optimism_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Optimism_AllowEmergencyAdminFreeze_20230829.sol';
import {AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829.sol';
import {AaveV3_Polygon_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Polygon_AllowEmergencyAdminFreeze_20230829.sol';
import {AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829.sol';
import {AaveV3_Metis_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Metis_AllowEmergencyAdminFreeze_20230829.sol';
import {AaveV3_Base_AllowEmergencyAdminFreeze_20230829} from './AaveV3_Base_AllowEmergencyAdminFreeze_20230829.sol';

/**
 * @dev Deploy AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829
 * command: make deploy-ledger contract=src/20230829_AaveV3_Multi_AllowEmergencyAdminFreeze/AaveV3_AllowEmergencyAdminFreeze_20230829.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_AllowEmergencyAdminFreeze_20230829();
  }
}

/**
 * @dev Deploy AaveV3_Optimism_AllowEmergencyAdminFreeze_20230829
 * command: make deploy-ledger contract=src/20230829_AaveV3_Multi_AllowEmergencyAdminFreeze/AaveV3_AllowEmergencyAdminFreeze_20230829.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Optimism_AllowEmergencyAdminFreeze_20230829();
  }
}

/**
 * @dev Deploy AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829
 * command: make deploy-ledger contract=src/20230829_AaveV3_Multi_AllowEmergencyAdminFreeze/AaveV3_AllowEmergencyAdminFreeze_20230829.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3_Arbitrum_AllowEmergencyAdminFreeze_20230829();
  }
}

/**
 * @dev Deploy AaveV3_Polygon_AllowEmergencyAdminFreeze_20230829
 * command: make deploy-ledger contract=src/20230829_AaveV3_Multi_AllowEmergencyAdminFreeze/AaveV3_AllowEmergencyAdminFreeze_20230829.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Polygon_AllowEmergencyAdminFreeze_20230829();
  }
}

/**
 * @dev Deploy AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829
 * command: make deploy-ledger contract=src/20230829_AaveV3_Multi_AllowEmergencyAdminFreeze/AaveV3_AllowEmergencyAdminFreeze_20230829.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3_Avalanche_AllowEmergencyAdminFreeze_20230829();
  }
}

/**
 * @dev Deploy AaveV3_Metis_AllowEmergencyAdminFreeze_20230829
 * command: make deploy-ledger contract=src/20230829_AaveV3_Multi_AllowEmergencyAdminFreeze/AaveV3_AllowEmergencyAdminFreeze_20230829.s.sol:DeployMetis chain=metis
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    new AaveV3_Metis_AllowEmergencyAdminFreeze_20230829();
  }
}

/**
 * @dev Deploy AaveV3_Base_AllowEmergencyAdminFreeze_20230829
 * command: make deploy-ledger contract=src/20230829_AaveV3_Multi_AllowEmergencyAdminFreeze/AaveV3_AllowEmergencyAdminFreeze_20230829.s.sol:DeployBase chain=base
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    new AaveV3_Base_AllowEmergencyAdminFreeze_20230829();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230829_AaveV3_Multi_AllowEmergencyAdminFreeze/AaveV3_AllowEmergencyAdminFreeze_20230829.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](6);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    payloads[1] = GovHelpers.buildOptimism(address(0));
    payloads[2] = GovHelpers.buildArbitrum(address(0));
    payloads[3] = GovHelpers.buildPolygon(address(0));
    payloads[4] = GovHelpers.buildMetis(address(0));
    payloads[5] = GovHelpers.buildBase(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230829_AaveV3_Multi_AllowEmergencyAdminFreeze/AllowEmergencyAdminFreeze.md'
      )
    );
  }
}
