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
    payloads[0] = GovHelpers.buildMainnet(address(0));
    payloads[1] = GovHelpers.buildMainnet(address(0));
    payloads[2] = GovHelpers.buildOptimism(address(0));
    payloads[3] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(payloads, 0x0);
  }
}
