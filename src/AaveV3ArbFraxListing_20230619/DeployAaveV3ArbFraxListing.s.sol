// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {ArbitrumScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbFraxListing_20230619} from 'src/AaveV3ArbFraxListing_20230619/AaveV3ArbFraxListing_20230619.sol';

contract DeployAaveV3FraxListingPayload is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbFraxListing_20230619();
  }
}

contract AaveV3FraxListingPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildArbitrum(
      address(0) //TODO
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3ArbFraxListing_20230619/TODO.md'
      )
    );
  }
}
