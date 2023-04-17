// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {GovHelpers, AaveGovernanceV2} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbRatesUpdates_20230307} from './AaveV3ArbRatesUpdates_20230307.sol';
import {AaveV3PolRatesUpdates_20230307} from './AaveV3PolRatesUpdates_20230307.sol';
import {AaveV3OptRatesUpdates_20230307} from './AaveV3OptRatesUpdates_20230307.sol';
import 'aave-helpers/ScriptUtils.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildPolygon(0xDBe6EB920ca5a79ae2151b6DCbd2c1Fa3A19aD1a);
    payloads[1] = GovHelpers.buildOptimism(0x7902F3c60f05b5A6b7e4Ce0Cac11Cb17bC8e607c);
    payloads[2] = GovHelpers.buildArbitrum(0x7A9A9c14B35E58ffa1cC84aB421acE0FdcD289E3);
    GovHelpers.createProposal(
      payloads,
      0x3b66ed0fa57bec842608cb1be68f97ca0c241cd3744a860086762f76cc0ae933,
      true
    );
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolRatesUpdates_20230307();
  }
}

contract DeployPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3OptRatesUpdates_20230307();
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbRatesUpdates_20230307();
  }
}
