pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript, ArbitrumScript} from 'aave-helpers/../script/Utils.s.sol';
import {AaveV3PolDebtCeiling_20230404,AaveV3ArbDebtCeiling_20230404} from './AaveV3DebtCeiling_20230404.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildPolygon(address(0));
    payloads[1] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(payloads, '');
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
