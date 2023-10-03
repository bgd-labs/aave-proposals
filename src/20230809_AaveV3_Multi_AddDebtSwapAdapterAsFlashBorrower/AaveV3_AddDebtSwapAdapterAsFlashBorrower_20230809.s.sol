// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript, ArbitrumScript, PolygonScript, AvalancheScript, BaseScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';
import {AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';
import {AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';
import {AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';
import {AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';
import {AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';

/**
 * @dev Deploy AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_AddDebtSwapAdapterAsFlashBorrower_20230809.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_AddDebtSwapAdapterAsFlashBorrower_20230809.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_AddDebtSwapAdapterAsFlashBorrower_20230809.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_AddDebtSwapAdapterAsFlashBorrower_20230809.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_AddDebtSwapAdapterAsFlashBorrower_20230809.s.sol:DeployAvalanche chain=avalanche
 * deployed at: https://snowtrace.io/address/0x1a7dde6344d5f2888209ddb446756fe292e1325e#code
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_AddDebtSwapAdapterAsFlashBorrower_20230809.s.sol:DeployBase chain=base
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    new AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_AddDebtSwapAdapterAsFlashBorrower_20230809.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](5);
    payloads[0] = GovHelpers.buildMainnet(0xbCb167bDCF14a8F791d6f4A6EDd964aed2F8813B);
    payloads[1] = GovHelpers.buildOptimism(0xc026f5dD7869e0dDC44a759Ea3dEC6d5Cd8D996b);
    payloads[2] = GovHelpers.buildArbitrum(0xa603Ad2b0258bDda94F3dfDb26859ef205AE9244);
    payloads[3] = GovHelpers.buildPolygon(0x89A943BAc327c9e217d70E57DCD57C7f2a8C3fA9);
    payloads[4] = GovHelpers.buildBase(0xA25d9f14CFA40d3227ED9a48B124667dDFfCFdDD);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AddDebtSwapAdapterAsFlashBorrower.md'
      )
    );
  }
}
