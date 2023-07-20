// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, AvalancheScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Eth_CrosschainInfrastructureFunding_20231907} from './AaveV3_Eth_CrosschainInfrastructureFunding_20231907.sol';
import {AaveV3_Ava_CrosschainInfrastructureFunding_20231907} from './AaveV3_Ava_CrosschainInfrastructureFunding_20231907.sol';
import {AaveV3_Pol_CrosschainInfrastructureFunding_20231907} from './AaveV3_Pol_CrosschainInfrastructureFunding_20231907.sol';

/**
 * @dev Deploy AaveV3_Eth_CrosschainInfrastructureFunding_20231907
 * command: make deploy-ledger contract=src/AaveV3_Multi_CrosschainInfrastructureFunding_20231907/AaveV3_Multi_CrosschainInfrastructureFunding_20231907.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Eth_CrosschainInfrastructureFunding_20231907();
  }
}

/**
 * @dev Deploy AaveV3_Ava_CrosschainInfrastructureFunding_20231907
 * command: make deploy-ledger contract=src/AaveV3_Multi_CrosschainInfrastructureFunding_20231907/AaveV3_Multi_CrosschainInfrastructureFunding_20231907.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3_Ava_CrosschainInfrastructureFunding_20231907();
  }
}

/**
 * @dev Deploy AaveV3_Pol_CrosschainInfrastructureFunding_20231907
 * command: make deploy-ledger contract=src/AaveV3_Multi_CrosschainInfrastructureFunding_20231907/AaveV3_Multi_CrosschainInfrastructureFunding_20231907.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Pol_CrosschainInfrastructureFunding_20231907();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Multi_CrosschainInfrastructureFunding_20231907/AaveV3_Multi_CrosschainInfrastructureFunding_20231907.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    payloads[1] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3_Multi_CrosschainInfrastructureFunding_20231907/CrosschainInfrastructureFunding.md'
      )
    );
  }
}
