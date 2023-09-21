import {generateContractName, getPoolChain, getVersion} from '../common';
import {CodeArtifact, DEPENDENCIES, Options, PoolIdentifier} from '../types';

function buildImport(options: Options, pool: PoolIdentifier, dependencies: DEPENDENCIES[]) {
  let template = '';
  const chain = getPoolChain(pool);
  const version = getVersion(pool);
  if (dependencies.includes(DEPENDENCIES.Engine)) {
    template += `import {Aave${version}Payload${chain}, IEngine, Rates, EngineFlags} from 'aave-helpers/${version.toLowerCase()}-config-engine/Aave${version}Payload${chain}.sol';`;
  } else {
    template += `import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';\n`;
  }
  if (dependencies.includes(DEPENDENCIES.Addresses) && dependencies.includes(DEPENDENCIES.Assets)) {
    template += `import {${pool}, ${pool}Assets} from 'aave-address-book/${pool}.sol';\n`;
  } else if (dependencies.includes(DEPENDENCIES.Addresses)) {
    template += `import {${pool}} from 'aave-address-book/${pool}.sol';\n`;
  } else if (dependencies.includes(DEPENDENCIES.Assets)) {
    template += `import {${pool}Assets} from 'aave-address-book/${pool}.sol';\n`;
  }

  return template;
}

export const proposalTemplate = (
  options: Options,
  pool: PoolIdentifier,
  artifacts: CodeArtifact[] = []
) => {
  const {title, author, snapshot, discussion} = options;
  const chain = getPoolChain(pool);
  const contractName = generateContractName(options, pool);

  const dependencies = [
    ...new Set(
      artifacts
        .map((a) => a.code?.dependencies)
        .flat()
        .filter((f) => f !== undefined)
    ),
  ];
  const imports = buildImport(options, pool, dependencies as DEPENDENCIES[]);
  const constants = artifacts
    .map((artifact) => artifact.code?.constants)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');
  const functions = artifacts
    .map((artifact) => artifact.code?.fn)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');

  // need to figure out if execute or pre/post
  let optionalExecute = '';
  if (dependencies.includes(DEPENDENCIES.Execute)) {
    const innerExecute = artifacts
      .map((artifact) => artifact.code?.execute)
      .flat()
      .filter((f) => f !== undefined)
      .join('\n');
    if (dependencies.includes(DEPENDENCIES.Engine)) {
      optionalExecute = `function _preExecute() internal override {
        ${innerExecute}
       }`;
    } else {
      optionalExecute = `function execute() external {
        ${innerExecute}
       }`;
    }
  }

  let template = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

${imports}

/**
 * @title ${title || 'TODO'}
 * @author ${author || 'TODO'}
 * - Snapshot: ${snapshot || 'TODO'}
 * - Discussion: ${discussion || 'TODO'}
 */
contract ${contractName} is ${
    dependencies.includes(DEPENDENCIES.Engine)
      ? `Aave${getVersion(pool)}Payload${chain}`
      : 'IProposalGenericExecutor'
  } {
  ${constants}

  ${optionalExecute}

  ${functions}
}`;
  return template;
};
