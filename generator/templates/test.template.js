import { createPublicClient, http } from "viem";
import {
  arbitrum,
  avalanche,
  mainnet,
  metis,
  optimism,
  polygon,
} from "viem/chains";
import { getAlias } from "../common.js";

const CHAIN_TO_EXECUTOR = {
  Ethereum: "AaveGovernanceV2.SHORT_EXECUTOR",
  Polygon: "AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR",
  Optimism: "AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR",
  Arbitrum: "AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR",
  Metis: "AaveGovernanceV2.METIS_BRIDGE_EXECUTOR",
  Avalanche: "0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian",
};

const CHAIN_TO_CHAIN_OBJECT = {
  Ethereum: mainnet,
  Polygon: polygon,
  Optimism: optimism,
  Arbitrum: arbitrum,
  Avalanche: avalanche,
  Metis: metis,
};

export const getBlock = async (chain) => {
  return await createPublicClient({
    chain: CHAIN_TO_CHAIN_OBJECT[chain],
    transport: http(),
  }).getBlockNumber();
};

export const testTemplate = async ({
  protocolVersion,
  chain,
  title,
  author,
  snapshot,
  discussion,
  contractName,
}) => `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {Aave${protocolVersion}${chain}, Aave${protocolVersion}${chain}Assets} from 'aave-address-book/Aave${protocolVersion}${chain}.sol';
import {Protocol${protocolVersion}TestBase, ReserveConfig} from 'aave-helpers/Protocol${protocolVersion}TestBase.sol';
import {${contractName}} from './${contractName}.sol';

/**
 * @dev Test for ${contractName}
 * command: make test-contract filter=${contractName}
 */
contract ${contractName}_Test is Protocol${protocolVersion}TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('${getAlias(chain)}'), ${await getBlock(
  chain
)});
  }

  function testProposalExecution() public {
    ${contractName} proposal = new ${contractName}();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre${contractName}',
      Aave${protocolVersion}${chain}.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      ${CHAIN_TO_EXECUTOR[chain]}
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'pre${contractName}',
      Aave${protocolVersion}${chain}.POOL
    );
  }
}`;
