// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolPriceFeedsUpdate_20230626_Payload} from './AaveV3PolPriceFeedsUpdate_20230626_Payload.sol';

contract DeployPolygonPayload is PolygonScript {
  function run() external broadcast {
    new AaveV3PolPriceFeedsUpdate_20230626_Payload();
  }
}

contract PriceFeedsUpdateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3PriceFeedsUpdate_20230626/PRICE-FEEDS-UPDATE-20230626.md'
      )
    );
  }
}
