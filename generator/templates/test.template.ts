import {createPublicClient, http} from 'viem';
import {arbitrum, avalanche, mainnet, metis, optimism, polygon, base} from 'viem/chains';
import {CHAIN_TO_EXECUTOR, getAlias} from '../common';

const CHAIN_TO_CHAIN_OBJECT = {
  Ethereum: mainnet,
  Polygon: polygon,
  Optimism: optimism,
  Arbitrum: arbitrum,
  Avalanche: avalanche,
  Metis: metis,
  Base: base,
};

export const getBlock = async (chain) => {
  return await createPublicClient({
    chain: CHAIN_TO_CHAIN_OBJECT[chain],
    transport: http(),
  }).getBlockNumber();
};

export const testTemplate = async (options, artifacts) => {
  const {protocolVersion, chain, title, author, snapshot, discussion, contractName, features} =
    options;

  const functions = artifacts
    .map((artifact) => artifact[chain].test?.fn)
    .flat()
    .filter((i) => i)
    .join('\n');
  let template = `// SPDX-License-Identifier: MIT
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
  ${contractName} internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('${getAlias(chain)}'), ${await getBlock(chain)});
    proposal = new ${contractName}();
  }

  function testProposalExecution() public {
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
      'post${contractName}',
      Aave${protocolVersion}${chain}.POOL
    );

    diffReports('pre${contractName}', 'post${contractName}');
  }

  ${functions}
}`;
  return template;
};
