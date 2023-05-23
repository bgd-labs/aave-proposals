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
    payloads[0] = GovHelpers.buildMainnet(address(0));
    payloads[1] = GovHelpers.buildPolygon(address(0));
    payloads[2] = GovHelpers.buildArbitrum(address(0));
    payloads[3] = GovHelpers.buildOptimism(address(0));
    payloads[4] = GovHelpers.buildMetis(address(0));
    GovHelpers.createProposal(payloads, '');
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