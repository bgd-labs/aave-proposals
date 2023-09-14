// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906} from './AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906.sol';

/**
 * @dev Deploy AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906
 * command: make deploy-ledger contract=src/20230906_AaveV3_Eth_QuarterlyGasRebateDistributionAugust2023/AaveV3_QuarterlyGasRebateDistributionAugust2023_20230906.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230906_AaveV3_Eth_QuarterlyGasRebateDistributionAugust2023/AaveV3_QuarterlyGasRebateDistributionAugust2023_20230906.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0xe0eCDE7e3Bf61f09A5C745154c736DE85a290d4A);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230906_AaveV3_Eth_QuarterlyGasRebateDistributionAugust2023/QuarterlyGasRebateDistributionAugust2023.md'
      )
    );
  }
}
