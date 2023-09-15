// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_GHOBorrowRateUpdate_20230904} from './AaveV3_Ethereum_GHOBorrowRateUpdate_20230904.sol';
import {GhoInterestRateStrategy} from 'src/20230904_AaveV3_Eth_GHOBorrowRateUpdate/GhoInterestRateStrategy.sol'; // Updated path

/**
 * @dev Deploy AaveV3_Ethereum_GHOBorrowRateUpdate_20230904
 * command: make deploy-ledger contract=src/20230904_AaveV3_Eth_GHOBorrowRateUpdate/AaveV3_GHOBorrowRateUpdate_20230904.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_GHOBorrowRateUpdate_20230904();
  }
}

/**
 * @dev Deploy GhoInterestRateStrategy
 * command: make deploy-ledger contract=src/20230904_AaveV3_Eth_GHOBorrowRateUpdate/AaveV3_GHOBorrowRateUpdate_20230904.s.sol:DeployInterestRateStrategy chain=mainnet
 */
contract DeployInterestRateStrategy is EthereumScript {
  function run() external broadcast {
    address poolAddressesProvider = 0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e;
    new GhoInterestRateStrategy(poolAddressesProvider);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230904_AaveV3_Eth_GHOBorrowRateUpdate/AaveV3_GHOBorrowRateUpdate_20230904.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x77c2Bf7d387D4d0C54dAd4221764f0aC0c289d24);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230904_AaveV3_Eth_GHOBorrowRateUpdate/GHOBorrowRateUpdate.md'
      )
    );
  }
}
