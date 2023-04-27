pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3ArbSupplyCapsUpdate_20230330} from './AaveV3ArbSupplyCapsUpdate_20230330.sol';

contract CreateProposal is ArbitrumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(payloads, '');
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbSupplyCapsUpdate_20230330();
  }
}
