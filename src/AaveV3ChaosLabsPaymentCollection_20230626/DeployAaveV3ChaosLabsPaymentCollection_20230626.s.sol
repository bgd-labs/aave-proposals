// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ChaosLabsPaymentCollection_20230626} from 'src/AaveV3ChaosLabsPaymentCollection_20230626/AaveV3ChaosLabsPaymentCollection_20230626.sol';

contract DeployMainnetPayload is EthereumScript {
  function run() external broadcast {
    new AaveV3ChaosLabsPaymentCollection_20230626();
  }
}

contract PayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // TODO: Replace by actual payload
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3ChaosLabsPaymentCollection_20230626/CHAOS-LABS-PAYMENT-COLLECTION-REQUEST-20230626.md'
      )
    );
  }
}
