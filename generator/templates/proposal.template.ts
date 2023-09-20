import {generateContractName} from '../common';
import {CodeArtifact, CodeArtifacts, DEPENDENCIES, Options, PoolIdentifier} from '../types';

function buildImport(options: Options, chain, dependencies: DEPENDENCIES[]) {
  let template = '';
  if (dependencies.includes(DEPENDENCIES.Engine)) {
    template += `import {Aave${
      options.protocolVersion
    }Payload${chain}, IEngine, Rates, EngineFlags} from 'aave-helpers/${options.protocolVersion.toLowerCase()}-config-engine/Aave${
      options.protocolVersion
    }Payload${chain}.sol';`;
  } else {
    template += `import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';\n`;
  }
  if (dependencies.includes(DEPENDENCIES.Addresses) && dependencies.includes(DEPENDENCIES.Assets)) {
    template += `import {Aave${options.protocolVersion}${chain}, Aave${options.protocolVersion}${chain}Assets} from 'aave-address-book/Aave${options.protocolVersion}${chain}.sol';\n`;
  } else if (dependencies.includes(DEPENDENCIES.Addresses)) {
    template += `import {Aave${options.protocolVersion}${chain}} from 'aave-address-book/Aave${options.protocolVersion}${chain}.sol';\n`;
  } else if (dependencies.includes(DEPENDENCIES.Assets)) {
    template += `import {Aave${options.protocolVersion}${chain}Assets} from 'aave-address-book/Aave${options.protocolVersion}${chain}.sol';\n`;
  }

  return template;
}

export const proposalTemplate = (
  options: Options,
  pool: PoolIdentifier,
  artifacts: CodeArtifact[] = []
) => {
  const {title, author, snapshot, discussion} = options;
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
  const innerExecute = artifacts
    .map((artifact) => artifact.code?.execute)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');
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
      ? `${options.protocolVersion}Payload${chain}`
      : 'IProposalGenericExecutor'
  } {
  ${constants}

  ${
    dependencies.includes(DEPENDENCIES.Engine)
      ? `function _preExecute() internal override {
          ${innerExecute}
         }`
      : `function execute() external {
          ${innerExecute}
         }`
  }

  ${functions}
}`;
  return template;
};
