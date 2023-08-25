// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum} from 'lib/aave-address-book/src/AaveV3Ethereum.sol';
import {AaveV3_Ethereum_GhoFreezing_20230825} from './AaveV3_Ethereum_GhoFreezing_20230825.sol';
import {GuardianFreezer} from './GuardianFreezer.sol';

/**
 * @dev Deploy GuardianFreezer
 * command: make deploy-ledger contract=src/20230825_AaveV3_Eth_GhoFreezing/AaveV3_GhoFreezing_20230825.s.sol:DeployGuardianFreezer chain=mainnet
 */
contract DeployGuardianFreezer is EthereumScript {
  function run() external broadcast {
    new GuardianFreezer(AaveV3Ethereum.ACL_MANAGER, AaveV3Ethereum.POOL_CONFIGURATOR);
  }
}

/**
 * @dev Deploy AaveV3_Ethereum_GhoFreezing_20230825
 * command: make deploy-ledger contract=src/20230825_AaveV3_Eth_GhoFreezing/AaveV3_GhoFreezing_20230825.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_GhoFreezing_20230825(address(0)); // TODO Add helper
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230825_AaveV3_Eth_GhoFreezing/AaveV3_GhoFreezing_20230825.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0)); // TODO
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230825_AaveV3_Eth_GhoFreezing/GhoFreezing.md')
    );
  }
}
