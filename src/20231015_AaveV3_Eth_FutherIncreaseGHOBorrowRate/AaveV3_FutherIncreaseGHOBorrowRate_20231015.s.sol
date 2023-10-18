// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015} from './AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015.sol';

/**
 * @dev Deploy AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015
 * command: make deploy-ledger contract=src/20231015_AaveV3_Eth_FutherIncreaseGHOBorrowRate/AaveV3_FutherIncreaseGHOBorrowRate_20231015.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231015_AaveV3_Eth_FutherIncreaseGHOBorrowRate/AaveV3_FutherIncreaseGHOBorrowRate_20231015.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x46d0655ad49a7b5dDA47fd68a60240a713eB1B09);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231015_AaveV3_Eth_FutherIncreaseGHOBorrowRate/FutherIncreaseGHOBorrowRate.md'
      )
    );
  }
}
