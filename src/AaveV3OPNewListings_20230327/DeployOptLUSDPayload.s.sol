pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {OptimismScript, EthereumScript} from 'aave-helpers/../script/Utils.s.sol';
import {AaveV3OPNewListings_20230327} from './AaveV3OPNewListings_20230327.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildOptimism(address(0));
    GovHelpers.createProposal(payloads, '');
  }
}

contract DeployPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3OPNewListings_20230327();
  }
}
