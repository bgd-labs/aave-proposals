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
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Deploy AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower.s.sol:DeployBase chain=base
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    new AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](5);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    payloads[1] = GovHelpers.buildOptimism(address(0));
    payloads[2] = GovHelpers.buildArbitrum(address(0));
    payloads[3] = GovHelpers.buildPolygon(address(0));
    payloads[4] = GovHelpers.buildBase(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AddDebtSwapAdapterAsFlashBorrower.md'
      )
    );
  }
}
