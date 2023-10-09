// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, AvalancheScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926} from './AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926.sol';

/**
 * @dev Deploy AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926
 * command: make deploy-ledger contract=src/20230926_AaveV3_Ava_EnablingUSDTAsCollateralOnAaveV3AVAXMarket/AaveV3_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230926_AaveV3_Ava_EnablingUSDTAsCollateralOnAaveV3AVAXMarket/AaveV3_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](0);

    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230926_AaveV3_Ava_EnablingUSDTAsCollateralOnAaveV3AVAXMarket/EnablingUSDTAsCollateralOnAaveV3AVAXMarket.md'
      )
    );
  }
}
