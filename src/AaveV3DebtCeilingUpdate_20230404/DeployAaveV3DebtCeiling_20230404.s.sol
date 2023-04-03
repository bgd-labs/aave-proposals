pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript, ArbitrumScript} from 'aave-helpers/../script/Utils.s.sol';
import {AaveV3PolDebtCeiling_20230404,AaveV3ArbDebtCeiling_20230404} from './AaveV3DebtCeiling_20230404.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildPolygon(0x6bcE15B789e537f3abA3C60CB183F0E8737f05eC);
    payloads[1] = GovHelpers.buildArbitrum(0x4393277B02ef3cA293990A772B7160a8c76F2443);
    GovHelpers.createProposal(payloads, 0xc3d2121ca8e90ce2bc2e715bec74f92cb2241e1b88a338a855661865402e2ea7);
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolDebtCeiling_20230404();
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbDebtCeiling_20230404();
  }
}
