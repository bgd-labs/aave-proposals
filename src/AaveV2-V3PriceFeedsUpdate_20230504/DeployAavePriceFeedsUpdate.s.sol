// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript, OptimismScript, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2PriceFeedsUpdate_20230504_Payload} from './AaveV2PriceFeedsUpdate_20230504_Payload.sol';
import {AaveV3OptPriceFeedsSentinelUpdate_20230504_Payload} from './AaveV3OptPriceFeedsSentinelUpdate_20230504_Payload.sol';
import {AaveV3ArbPriceFeedsUpdate_20230504_Payload} from './AaveV3ArbPriceFeedsUpdate_20230504_Payload.sol';

contract DeployMainnetPayload is EthereumScript {
  function run() external broadcast {
    new AaveV2PriceFeedsUpdate_20230504_Payload();
  }
}

contract DeployOptimismPayload is OptimismScript {
  function run() external broadcast {
    new AaveV3OptPriceFeedsSentinelUpdate_20230504_Payload();
  }
}

contract DeployArbitrumPayload is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbPriceFeedsUpdate_20230504_Payload();
  }
}

contract PriceFeedsUpdateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](4);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // TODO: Replace by actual payload
    );
    payloads[1] = GovHelpers.buildOptimism(
      address(0) // TODO: Replace by actual payload
    );
    payloads[2] = GovHelpers.buildArbitrum(
      address(0) // TODO: Replace by actual payload
    );
    payloads[3] = GovHelpers.buildPolygon(
      address(0) // TODO: Replace by actual payload
    );
    GovHelpers.createProposal(
      payloads,
      0 // TODO: replace by actual Hash
    );
  }
}
