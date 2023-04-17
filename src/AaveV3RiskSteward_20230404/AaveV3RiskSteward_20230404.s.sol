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
import {AaveV3RiskSteward_20230404} from './AaveV3RiskSteward_20230404.sol';
import {CapsPlusRiskSteward, RiskStewardLibrary} from './CapsPlusRiskSteward.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](4);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    payloads[1] = GovHelpers.buildPolygon(address(0));
    payloads[2] = GovHelpers.buildArbitrum(address(0));
    payloads[3] = GovHelpers.buildOptimism(address(0));
    GovHelpers.createProposal(payloads, '');
  }
}

library DeployRiskSteward {
  /**
   * Deploys the steward and the proposal to pass permissions
   * @param configurator Pool configurator
   * @param poolDataProvider Pool data rpovider
   * @param aclManager ACL manager
   * @param council multisig performing the cap updates
   */
  function _deploy(
    IPoolConfigurator configurator,
    IPoolDataProvider poolDataProvider,
    IACLManager aclManager,
    address council
  ) internal {
    require(council != address(0), 'COUNCIL_MUST_BE_MULTISIG');
    CapsPlusRiskSteward steward = new CapsPlusRiskSteward(configurator, poolDataProvider, council);
    AaveV3RiskSteward_20230404 proposalPayload = new AaveV3RiskSteward_20230404(
      aclManager,
      address(steward)
    );
  }
}

contract DeployPayloadEthereum is EthereumScript {
  function run() external broadcast {
    DeployRiskSteward._deploy(
      AaveV3Ethereum.POOL_CONFIGURATOR,
      AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Ethereum.ACL_MANAGER,
      address(0)
    );
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    DeployRiskSteward._deploy(
      AaveV3Polygon.POOL_CONFIGURATOR,
      AaveV3Polygon.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Polygon.ACL_MANAGER,
      address(0)
    );
  }
}

contract DeployPayloadOptimism is OptimismScript {
  function run() external broadcast {
    DeployRiskSteward._deploy(
      AaveV3Optimism.POOL_CONFIGURATOR,
      AaveV3Optimism.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Optimism.ACL_MANAGER,
      address(0)
    );
  }
}

contract DeployPayloadArbitrum is ArbitrumScript {
  function run() external broadcast {
    DeployRiskSteward._deploy(
      AaveV3Arbitrum.POOL_CONFIGURATOR,
      AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Arbitrum.ACL_MANAGER,
      address(0)
    );
  }
}

contract DeployPayloadAvalanche is AvalancheScript {
  function run() external broadcast {
    DeployRiskSteward._deploy(
      AaveV3Avalanche.POOL_CONFIGURATOR,
      AaveV3Avalanche.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Avalanche.ACL_MANAGER,
      address(0)
    );
  }
}

contract DeployPayloadFantom is FantomScript {
  function run() external broadcast {
    DeployRiskSteward._deploy(
      AaveV3Fantom.POOL_CONFIGURATOR,
      AaveV3Fantom.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Fantom.ACL_MANAGER,
      address(0)
    );
  }
}
