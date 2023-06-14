// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript, OptimismScript, ArbitrumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2PriceFeedsUpdate_20230613_Payload} from './AaveV2PriceFeedsUpdate_20230613_Payload.sol';
import {AaveV3PriceFeedsUpdate_20230613_Payload} from './AaveV3PriceFeedsUpdate_20230613_Payload.sol';
import {AaveV3OptPriceFeedsUpdate_20230613_Payload} from './AaveV3OptPriceFeedsUpdate_20230613_Payload.sol';
import {AaveV3ArbPriceFeedsUpdate_20230613_Payload} from './AaveV3ArbPriceFeedsUpdate_20230613_Payload.sol';

contract DeployMainnetV2Payload is EthereumScript {
  function run() external broadcast {
    new AaveV2PriceFeedsUpdate_20230613_Payload();
  }
}

contract DeployMainnetV3Payload is EthereumScript {
  function run() external broadcast {
    new AaveV3PriceFeedsUpdate_20230613_Payload();
  }
}

contract DeployOptimismPayload is OptimismScript {
  function run() external broadcast {
    new AaveV3OptPriceFeedsUpdate_20230613_Payload();
  }
}

contract DeployArbitrumPayload is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ArbPriceFeedsUpdate_20230613_Payload();
  }
}

contract PriceFeedsUpdateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](4);
    payloads[0] = GovHelpers.buildMainnet(0x004F81e8880A40cf605C72e785a3F98eF16EcbF3);
    payloads[1] = GovHelpers.buildMainnet(0x42c5A9CCd4626251f3E64a08a9968023A34e84dE);
    payloads[2] = GovHelpers.buildOptimism(0x945fD405773973d286De54E44649cc0d9e264F78);
    payloads[3] = GovHelpers.buildArbitrum(0x7fc3FCb14eF04A48Bb0c12f0c39CD74C249c37d8);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2-V3PriceFeedsUpdate_20230613/PRICE-FEEDS-UPDATE-20230613.md'
      )
    );
  }
}
