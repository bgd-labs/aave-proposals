// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Opt_RiskParamsUpdate_20232408} from './AaveV3_Opt_RiskParamsUpdate_20232408.sol';

/**
 * @dev Deploy AaveV3_Opt_RiskParamsUpdate_20232408
 * command: make deploy-ledger contract=src/AaveV3_Opt_RiskParamsUpdate_20232408/AaveV3_Opt_RiskParamsUpdate_20232408.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Opt_RiskParamsUpdate_20232408();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Opt_RiskParamsUpdate_20232408/AaveV3_Opt_RiskParamsUpdate_20232408.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildOptimism(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Opt_RiskParamsUpdate_20232408/RiskParamsUpdate.md')
    );
  }
}
