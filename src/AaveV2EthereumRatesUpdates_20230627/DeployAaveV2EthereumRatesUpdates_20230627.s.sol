// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2EthereumRatesUpdates_20230627} from 'src/AaveV2EthereumRatesUpdates_20230627/AaveV2EthereumRatesUpdates_20230627.sol';

contract DeployMainnetPayload is EthereumScript {
  function run() external broadcast {
    new AaveV2EthereumRatesUpdates_20230627();
  }
}

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0)); // TODO: Replace by actual payload
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2EthereumRatesUpdates_20230627/ETHEREUM_V2_PARAMETER_UPDATES-20230627.md'
      )
    );
  }
}
