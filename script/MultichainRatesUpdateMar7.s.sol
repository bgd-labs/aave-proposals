// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {GovHelpers, AaveGovernanceV2} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolRatesUpdate} from '../src/contracts/polygon/AaveV3PolRatesUpdate-Mar7.sol';
import {AaveV3OptRatesUpdate} from '../src/contracts/optimism/AaveV3OptRatesUpdate-Mar7.sol';
import {AaveV3ArbRatesUpdate} from '../src/contracts/arbitrum/AaveV3ArbRatesUpdate-Mar7.sol';
import 'aave-helpers/../script/Utils.s.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
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
      bytes32('') // TODO add IPFS hash
    );
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolRatesUpdate();
  }
}

contract DeployPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3PolRatesUpdate();
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbRatesUpdate();
  }
}
