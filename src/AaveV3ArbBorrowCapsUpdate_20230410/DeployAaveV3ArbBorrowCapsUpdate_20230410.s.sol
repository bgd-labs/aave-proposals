pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ArbitrumScript} from 'aave-helpers/../script/Utils.s.sol';
import {AaveV3ArbBorrowCapsUpdate_20230410} from './AaveV3ArbBorrowCapsUpdate_20230410.sol';

contract CreateProposal is ArbitrumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(payloads, '');
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbBorrowCapsUpdate_20230410();
  }
}