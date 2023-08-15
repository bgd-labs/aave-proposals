// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript, ArbitrumScript, PolygonScript, AvalancheScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_StataTokenOperationalUpdate_20230815} from './AaveV3_Ethereum_StataTokenOperationalUpdate_20230815.sol';
import {AaveV3_Optimism_StataTokenOperationalUpdate_20230815} from './AaveV3_Optimism_StataTokenOperationalUpdate_20230815.sol';
import {AaveV3_Arbitrum_StataTokenOperationalUpdate_20230815} from './AaveV3_Arbitrum_StataTokenOperationalUpdate_20230815.sol';
import {AaveV3_Polygon_StataTokenOperationalUpdate_20230815} from './AaveV3_Polygon_StataTokenOperationalUpdate_20230815.sol';
import {AaveV3_Avalanche_StataTokenOperationalUpdate_20230815} from './AaveV3_Avalanche_StataTokenOperationalUpdate_20230815.sol';

/**
 * @dev Deploy AaveV3_Ethereum_StataTokenOperationalUpdate_20230815
 * command: make deploy-ledger contract=src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_StataTokenOperationalUpdate_20230815.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_StataTokenOperationalUpdate_20230815();
  }
}

/**
 * @dev Deploy AaveV3_Optimism_StataTokenOperationalUpdate_20230815
 * command: make deploy-ledger contract=src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_StataTokenOperationalUpdate_20230815.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Optimism_StataTokenOperationalUpdate_20230815();
  }
}

/**
 * @dev Deploy AaveV3_Arbitrum_StataTokenOperationalUpdate_20230815
 * command: make deploy-ledger contract=src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_StataTokenOperationalUpdate_20230815.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3_Arbitrum_StataTokenOperationalUpdate_20230815();
  }
}

/**
 * @dev Deploy AaveV3_Polygon_StataTokenOperationalUpdate_20230815
 * command: make deploy-ledger contract=src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_StataTokenOperationalUpdate_20230815.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Polygon_StataTokenOperationalUpdate_20230815();
  }
}

/**
 * @dev Deploy AaveV3_Avalanche_StataTokenOperationalUpdate_20230815
 * command: make deploy-ledger contract=src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_StataTokenOperationalUpdate_20230815.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3_Avalanche_StataTokenOperationalUpdate_20230815();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/20230815_AaveV3_Multi_StataTokenOperationalUpdate.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](4);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    payloads[1] = GovHelpers.buildOptimism(address(0));
    payloads[2] = GovHelpers.buildArbitrum(address(0));
    payloads[3] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/StataTokenOperationalUpdate.md'));
  }
}