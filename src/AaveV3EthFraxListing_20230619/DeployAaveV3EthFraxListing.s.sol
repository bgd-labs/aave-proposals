// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthFraxListing_20230619} from 'src/AaveV3EthFraxListing_20230619/AaveV3EthFraxListing_20230619.sol';

contract DeployAaveV3FraxListingPayload is EthereumScript {
  function run() external broadcast {
    new AaveV3EthFraxListing_20230619();
  }
}

contract AaveV3FraxListingPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0x56Cf1dbd6CfCA7898BA6A96Ce1Fbf1F038E6466b
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3EthFraxListing_20230619/ADD_FRAX_ETHEREUM_V3.md'
      )
    );
  }
}
