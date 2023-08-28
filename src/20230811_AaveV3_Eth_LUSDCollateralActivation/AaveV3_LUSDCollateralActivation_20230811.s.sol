// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_LUSDCollateralActivation_20230811} from './AaveV3_Ethereum_LUSDCollateralActivation_20230811.sol';

/**
 * @dev Deploy AaveV3_Ethereum_LUSDCollateralActivation_20230811
 * command: make deploy-ledger contract=src/20230811_AaveV3_Eth_LUSDCollateralActivation/AaveV3_LUSDCollateralActivation_20230811.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_LUSDCollateralActivation_20230811();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230811_AaveV3_Eth_LUSDCollateralActivation/AaveV3_LUSDCollateralActivation_20230811.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x96b3Fe1bcc88903BcdB032b09fbb16Ee0F908B43);
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/20230811_AaveV3_Eth_LUSDCollateralActivation/LUSDCollateralActivation.md'));
  }
}