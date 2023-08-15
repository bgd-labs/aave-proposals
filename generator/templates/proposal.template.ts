import {CodeArtifacts} from '../types';

export const proposalTemplate = (
  {protocolVersion, chain, title, author, snapshot, discussion, contractName, features},
  artifacts: CodeArtifacts[]
) => {
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

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {Aave${protocolVersion}${chain}, Aave${protocolVersion}${chain}Assets} from 'aave-address-book/Aave${protocolVersion}${chain}.sol';

/**
 * @title ${title || 'TODO'}
 * @author ${author || 'TODO'}
 * - Snapshot: ${snapshot || 'TODO'}
 * - Discussion: ${discussion || 'TODO'}
 */
contract ${contractName} is IProposalGenericExecutor {
  ${constants}

  ${innerExecute}

  ${functions}
}`;
  return template;
};
