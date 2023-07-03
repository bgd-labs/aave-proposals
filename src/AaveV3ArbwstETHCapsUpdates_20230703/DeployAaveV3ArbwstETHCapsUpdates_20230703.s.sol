// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {EthereumScript, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbwstETHCapsUpdates_20230703} from './AaveV3ArbwstETHCapsUpdates_20230703.sol';

contract DeployArbitrumPayload is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbwstETHCapsUpdates_20230703();
  }
}

contract PayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildArbitrum(
      address(0) // TODO: Replace by actual payload
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3ArbwstETHCapsUpdates_20230703/AAVE-V3-ARB-WSTETH-SUPPLY-CAP-UPDATE-20230703.md'
      )
    );
  }
}
