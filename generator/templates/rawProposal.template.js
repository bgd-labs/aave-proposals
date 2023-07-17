export const rawProposalTemplate = ({
  protocolVersion,
  chain,
  title,
  author,
  snapshot,
  discussion,
  contractName,
}) => `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {Aave${protocolVersion}${chain}, Aave${protocolVersion}${chain}Assets} from 'aave-address-book/Aave${protocolVersion}${chain}.sol';


/**
 * @title ${title || "TODO"}
 * @author ${author || "TODO"}
 * - Snapshot: ${snapshot || "TODO"}
 * - Discussion: ${discussion || "TODO"}
 */
contract ${contractName} is IProposalGenericExecutor {

  function execute() external {

  }

}`;
