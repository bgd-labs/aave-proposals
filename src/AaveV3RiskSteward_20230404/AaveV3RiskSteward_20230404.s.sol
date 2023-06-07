// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {IACLManager, IPoolConfigurator, IPoolDataProvider} from 'aave-address-book/AaveV3.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3Fantom} from 'aave-address-book/AaveV3Fantom.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3RiskSteward_20230404} from './AaveV3RiskSteward_20230404.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](5);
    payloads[0] = GovHelpers.buildMainnet(0x90127A46207e97e4205db5CCC1Ec9D6D43633FD4);
    payloads[1] = GovHelpers.buildPolygon(0x4C0633Bf70fB2bB984A9eEC5d9052BdEA451C70A);
    payloads[2] = GovHelpers.buildArbitrum(0xE79Ca44408Dae5a57eA2a9594532f1E84d2edAa4);
    payloads[3] = GovHelpers.buildOptimism(0xA3e44d830440dF5098520F62Ebec285B1198c51E);
    payloads[4] = GovHelpers.buildMetis(0xd91d1331db4F436DaF47Ec9Dd86deCb8EEF946B4);
    GovHelpers.createProposal(
      payloads,
      0x40110ec9619df34dcd84c1b553fe2bbd51e433e4e96caafb85b0949745790620
    );
  }
}

contract DeployPayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3RiskSteward_20230404(
      AaveV3Ethereum.ACL_MANAGER,
      AaveV3Ethereum.CAPS_PLUS_RISK_STEWARD
    );
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3RiskSteward_20230404(AaveV3Polygon.ACL_MANAGER, AaveV3Polygon.CAPS_PLUS_RISK_STEWARD);
  }
}

contract DeployPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3RiskSteward_20230404(
      AaveV3Optimism.ACL_MANAGER,
      AaveV3Optimism.CAPS_PLUS_RISK_STEWARD
    );
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3RiskSteward_20230404(
      AaveV3Arbitrum.ACL_MANAGER,
      AaveV3Arbitrum.CAPS_PLUS_RISK_STEWARD
    );
  }
}

contract DeployPayloadAvalanche is AvalancheScript {
  // 0x7e1f23bdfc7287af276f77b5a867e85cf0377a31
  function run() external broadcast {
    new AaveV3RiskSteward_20230404(
      AaveV3Avalanche.ACL_MANAGER,
      AaveV3Avalanche.CAPS_PLUS_RISK_STEWARD
    );
  }
}

contract DeployPayloadMetis is MetisScript {
  function run() external broadcast {
    new AaveV3RiskSteward_20230404(AaveV3Metis.ACL_MANAGER, AaveV3Metis.CAPS_PLUS_RISK_STEWARD);
  }
}
