pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ArbitrumScript,EthereumScript} from 'aave-helpers/../script/Utils.s.sol';
import {AaveV3ArbBorrowCapsUpdate_20230410} from './AaveV3ArbBorrowCapsUpdate_20230410.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildArbitrum(0x31976DC2Ea27E75cC5a3687ED594D17127f9b72E);
    GovHelpers.createProposal(payloads, 0x464496497d766fa1724c5fb3e6f501d7c89ed662109536184efdf6d925789186);
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbBorrowCapsUpdate_20230410();
  }
}
