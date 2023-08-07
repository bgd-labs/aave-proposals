// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Eth_CRV_OTC_Deal_20230508} from './AaveV2_Eth_CRV_OTC_Deal_20230508.sol';

/**
 * @dev Deploy AaveV2_Eth_CRV_OTC_Deal_20230508
 * command: make deploy-ledger contract=src/AaveV2_Eth_CRV_OTC_Deal_20230508/AaveV2_Eth_CRV_OTC_Deal_20230508.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2_Eth_CRV_OTC_Deal_20230508();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV2_Eth_CRV_OTC_Deal_20230508/AaveV2_Eth_CRV_OTC_Deal_20230508.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x8eDa0756f0d7DffC8488A19cF3B949BEbD132191);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV2_Eth_CRV_OTC_Deal_20230508/CRV_OTC_Deal.md')
    );
  }
}
