// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008} from './AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008.sol';

/**
 * @dev Deploy AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008
 * command: make deploy-ledger contract=src/20231008_AaveV3_Eth_KNCOnboardingOnAaveV3EthereumMarket/AaveV3_KNCOnboardingOnAaveV3EthereumMarket_20231008.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231008_AaveV3_Eth_KNCOnboardingOnAaveV3EthereumMarket/AaveV3_KNCOnboardingOnAaveV3EthereumMarket_20231008.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x29Ba7784aB57dB44c51CCd3743Aa2B792F8523ac);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231008_AaveV3_Eth_KNCOnboardingOnAaveV3EthereumMarket/KNCOnboardingOnAaveV3EthereumMarket.md'
      )
    );
  }
}
