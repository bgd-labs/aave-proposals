// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Optimism_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004} from './AaveV3_Optimism_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004.sol';
import {AaveV3_Arbitrum_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004} from './AaveV3_Arbitrum_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004.sol';

/**
 * @dev Deploy AaveV3_Optimism_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004
 * command: make deploy-ledger contract=src/20231004_AaveV3_Multi_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3/AaveV3_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Optimism_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004();
  }
}

/**
 * @dev Deploy AaveV3_Arbitrum_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004
 * command: make deploy-ledger contract=src/20231004_AaveV3_Multi_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3/AaveV3_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3_Arbitrum_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231004_AaveV3_Multi_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3/AaveV3_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3_20231004.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildOptimism(address(0));
    payloads[1] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231004_AaveV3_Multi_GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3/GauntletRecommendationsToLowerWETHVariableBaseTo0OnArbitrumOptimismV3.md'
      )
    );
  }
}
