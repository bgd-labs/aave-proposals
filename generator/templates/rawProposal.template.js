import { NON_ENGINE_FEATURES } from "../generator.js";

export const rawProposalTemplate = ({
  protocolVersion,
  chain,
  title,
  author,
  snapshot,
  discussion,
  contractName,
  features,
}) => {
  let template = `// SPDX-License-Identifier: MIT
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
  address public constant NEW_FLASH_BORROWER = address(0);

  function execute() external {\n`;
  if (features.includes(NON_ENGINE_FEATURES.flashBorrower.value)) {
    template += `Aave${protocolVersion}${chain}.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);`;
  }
  template += `  }

}`;
  return template;
};
