// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Optimism_OPRiskParametersUpdate_20230924} from './AaveV3_Optimism_OPRiskParametersUpdate_20230924.sol';

/**
 * @dev Deploy AaveV3_Optimism_OPRiskParametersUpdate_20230924
 * command: make deploy-ledger contract=src/20230924_AaveV3_Opt_OPRiskParametersUpdate/AaveV3_OPRiskParametersUpdate_20230924.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Optimism_OPRiskParametersUpdate_20230924();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230924_AaveV3_Opt_OPRiskParametersUpdate/AaveV3_OPRiskParametersUpdate_20230924.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildOptimism(0xe704Efe305b14BDDbba3d6C7f4A559149EdC1339);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230924_AaveV3_Opt_OPRiskParametersUpdate/OPRiskParametersUpdate.md'
      )
    );
  }
}
