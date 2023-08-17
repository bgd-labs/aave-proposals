import {generateContractName} from '../common';
import {CodeArtifacts, DEPENDENCIES, Options} from '../types';

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

export const proposalTemplate = (options: Options, chain, artifacts: CodeArtifacts[]) => {
  const {protocolVersion, title, author, snapshot, discussion, features} = options;
  const contractName = generateContractName(options, chain);

  const dependencies = [
    ...new Set(
      artifacts
        .map((a) => a[chain].code?.dependencies)
        .flat()
        .filter((f) => f)
    ),
  ];
  const imports = buildImport(options, chain, dependencies as DEPENDENCIES[]);
  const constants = artifacts
    .map((artifact) => artifact[chain].code?.constants)
    .flat()
    .filter((i) => i)
    .join('\n');
  const functions = artifacts
    .map((artifact) => artifact[chain].code?.fn)
    .flat()
    .filter((i) => i)
    .join('\n');

  // need to figure out if execute or pre/post
  const innerExecute = artifacts
    .map((artifact) => artifact[chain].code?.execute)
    .flat()
    .filter((i) => i)
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
      ? `Aave${options.protocolVersion}Payload${chain}`
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
