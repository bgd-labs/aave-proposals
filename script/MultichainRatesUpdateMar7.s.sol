// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {GovHelpers, AaveGovernanceV2} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolRatesUpdateMar7} from '../src/contracts/polygon/AaveV3PolRatesUpdate-Mar7.sol';
import {AaveV3OptRatesUpdateMar7} from '../src/contracts/optimism/AaveV3OptRatesUpdate-Mar7.sol';
import {AaveV3ArbRatesUpdateMar7} from '../src/contracts/arbitrum/AaveV3ArbRatesUpdate-Mar7.sol';
import 'aave-helpers/../script/Utils.s.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildPolygon(
      address(0) // TODO add payload address
    );
    payloads[1] = GovHelpers.buildOptimism(
      address(0) // TODO add payload address
    );
    payloads[2] = GovHelpers.buildArbitrum(
      address(0) // TODO add payload address
    );
    GovHelpers.createProposal(
      payloads,
      0x3b66ed0fa57bec842608cb1be68f97ca0c241cd3744a860086762f76cc0ae933,
      true
    );
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolRatesUpdateMar7();
  }
}

contract DeployPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3OptRatesUpdateMar7();
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbRatesUpdateMar7();
  }
}
