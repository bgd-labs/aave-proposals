pragma solidity ^0.8.17;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Eth1INCHListing_20230517_Payload} from './AaveV3Eth1INCHListing_20230517_Payload.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0)); // TODO: change to actual payload address after deployment
    GovHelpers.createProposal(payloads, ''); // TODO: change to IPFS hash after AIP merged
  }
}

contract DeployPayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3Eth1INCHListing_20230517_Payload();
  }
}
