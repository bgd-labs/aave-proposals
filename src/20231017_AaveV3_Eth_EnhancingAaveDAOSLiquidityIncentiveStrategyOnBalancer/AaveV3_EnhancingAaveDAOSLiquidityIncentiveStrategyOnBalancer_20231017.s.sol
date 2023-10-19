// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017} from './AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017.sol';

/**
 * @dev Deploy AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017
 * command: make deploy-ledger contract=src/20231017_AaveV3_Eth_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer/AaveV3_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231017_AaveV3_Eth_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer/AaveV3_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x8E6701Bfd7FACB64Fb0d6F368BeB5E1C3b13115E);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231017_AaveV3_Eth_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer/EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer.md'
      )
    );
  }
}
