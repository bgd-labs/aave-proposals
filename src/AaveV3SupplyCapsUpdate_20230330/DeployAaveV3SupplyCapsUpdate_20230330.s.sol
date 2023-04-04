pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbSupplyCapsUpdate_20230330} from './AaveV3ArbSupplyCapsUpdate_20230330.sol';
import {AaveV3OptSupplyCapsUpdate_20230330} from './AaveV3OptSupplyCapsUpdate_20230330.sol';
import 'aave-helpers/../script/Utils.s.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[1] = GovHelpers.buildOptimism(address(0));
    payloads[2] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(
      payloads,
      '',
      true
    );
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbSupplyCapsUpdate_20230330();
  }
}

contract DeployPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3OptSupplyCapsUpdate_20230330();
  }
}