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
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildMainnet(0xab22988D93d5F942fC6B6c6Ea285744809D1d9Cc);
    payloads[1] = GovHelpers.buildOptimism(0x3105C276558Dd4cf7E7be71d73Be8D33bD18F211);
    payloads[2] = GovHelpers.buildArbitrum(0x80f2c02224a2E548FC67c0bF705eBFA825dd5439);
    GovHelpers.createProposal(
      payloads,
      0xc6e257cf3e6b0c9b270d31776233ad32e4714277262d769b8979a8acafb4b321
    );
  }
}
