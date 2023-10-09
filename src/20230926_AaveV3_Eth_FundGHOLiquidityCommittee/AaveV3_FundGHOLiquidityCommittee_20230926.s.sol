// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926} from './AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926.sol';

/**
 * @dev Deploy AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926
 * command: make deploy-ledger contract=src/20230926_AaveV3_Eth_FundGHOLiquidityCommittee/AaveV3_FundGHOLiquidityCommittee_20230926.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230926_AaveV3_Eth_FundGHOLiquidityCommittee/AaveV3_FundGHOLiquidityCommittee_20230926.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x5F8Cb9A8e12377aAe2f534813c51eEC7e36D2772);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230926_AaveV3_Eth_FundGHOLiquidityCommittee/FundGHOLiquidityCommittee.md'
      )
    );
  }
}
