// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ethFUSDCListing_20230605} from 'src/AaveV3ethFUSDCListing_20230605/AaveV3ethFUSDCListing_20230605.sol';

contract DeployFUSDCPayload is EthereumScript {
  function run() external broadcast {
    new AaveV3ethFUSDCListing_20230605();
  }
}

contract CreateFUSDC is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // TO-DO Replace by actual payload
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3ethFUSDCListing_20230605/AAVEV3-ADD-FUSDC-AIP.md',
      )
    );
  }
}
