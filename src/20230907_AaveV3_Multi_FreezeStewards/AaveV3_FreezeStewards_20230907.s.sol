// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript, ArbitrumScript, PolygonScript, AvalancheScript, MetisScript, BaseScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Optimism_FreezeStewards_20230907} from './AaveV3_Optimism_FreezeStewards_20230907.sol';
import {AaveV3_Arbitrum_FreezeStewards_20230907} from './AaveV3_Arbitrum_FreezeStewards_20230907.sol';
import {AaveV3_Polygon_FreezeStewards_20230907} from './AaveV3_Polygon_FreezeStewards_20230907.sol';
import {AaveV3_Avalanche_FreezeStewards_20230907} from './AaveV3_Avalanche_FreezeStewards_20230907.sol';
import {AaveV3_Metis_FreezeStewards_20230907} from './AaveV3_Metis_FreezeStewards_20230907.sol';
import {AaveV3_Base_FreezeStewards_20230907} from './AaveV3_Base_FreezeStewards_20230907.sol';

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import {FreezingSteward} from './FreezingSteward.sol';

/**
 * @dev Deploy AaveV3_Optimism_FreezeStewards_20230907
 * command: make deploy-ledger contract=src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_FreezeStewards_20230907.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    address optimismFreezingSteward = address(
      new FreezingSteward(AaveV3Optimism.ACL_MANAGER, AaveV3Optimism.POOL_CONFIGURATOR)
    );
    new AaveV3_Optimism_FreezeStewards_20230907(optimismFreezingSteward);
  }
}

/**
 * @dev Deploy AaveV3_Arbitrum_FreezeStewards_20230907
 * command: make deploy-ledger contract=src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_FreezeStewards_20230907.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    address arbitrumFreezingSteward = address(
      new FreezingSteward(AaveV3Arbitrum.ACL_MANAGER, AaveV3Arbitrum.POOL_CONFIGURATOR)
    );
    new AaveV3_Arbitrum_FreezeStewards_20230907(arbitrumFreezingSteward);
  }
}

/**
 * @dev Deploy AaveV3_Polygon_FreezeStewards_20230907
 * command: make deploy-ledger contract=src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_FreezeStewards_20230907.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    address polygonFreezingSteward = address(
      new FreezingSteward(AaveV3Polygon.ACL_MANAGER, AaveV3Polygon.POOL_CONFIGURATOR)
    );
    new AaveV3_Polygon_FreezeStewards_20230907(polygonFreezingSteward);
  }
}

/**
 * @dev Deploy AaveV3_Avalanche_FreezeStewards_20230907
 * command: make deploy-ledger contract=src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_FreezeStewards_20230907.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    address avalancheFreezingSteward = address(
      new FreezingSteward(AaveV3Avalanche.ACL_MANAGER, AaveV3Avalanche.POOL_CONFIGURATOR)
    );
    new AaveV3_Avalanche_FreezeStewards_20230907(avalancheFreezingSteward);
  }
}

/**
 * @dev Deploy AaveV3_Metis_FreezeStewards_20230907
 * command: make deploy-ledger contract=src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_FreezeStewards_20230907.s.sol:DeployMetis chain=metis
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    address metisFreezingSteward = address(
      new FreezingSteward(AaveV3Metis.ACL_MANAGER, AaveV3Metis.POOL_CONFIGURATOR)
    );
    new AaveV3_Metis_FreezeStewards_20230907(metisFreezingSteward);
  }
}

/**
 * @dev Deploy AaveV3_Base_FreezeStewards_20230907
 * command: make deploy-ledger contract=src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_FreezeStewards_20230907.s.sol:DeployBase chain=base
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    address baseFreezingSteward = address(
      new FreezingSteward(AaveV3Base.ACL_MANAGER, AaveV3Base.POOL_CONFIGURATOR)
    );
    new AaveV3_Base_FreezeStewards_20230907(baseFreezingSteward);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_FreezeStewards_20230907.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](5);
    payloads[0] = GovHelpers.buildOptimism(0xe59470B3BE3293534603487E00A44C72f2CD466d);
    payloads[1] = GovHelpers.buildArbitrum(0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf);
    payloads[2] = GovHelpers.buildPolygon(0xAE93BEa44dcbE52B625169588574d31e36fb3A67);
    payloads[3] = GovHelpers.buildMetis(0x250F1c4D85Fa52848956c3A6b746869A4ee4d2cc);
    payloads[4] = GovHelpers.buildBase(0x889c0cc3283DB588A34E89Ad1E8F25B0fc827b4b);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230907_AaveV3_Multi_FreezeStewards/FreezeStewards.md')
    );
  }
}
