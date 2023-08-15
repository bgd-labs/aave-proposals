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
  let contractVars = [];
  let executeCommands = [];
  if (features.includes(NON_ENGINE_FEATURES.flashBorrower.value)) {
    contractVars.push(
      "address public constant NEW_FLASH_BORROWER = address(0);"
    );
    executeCommands.push(
      `Aave${protocolVersion}${chain}.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);`
    );
  }

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
  ${contractVars.join("\n")}

  function execute() external {
    ${executeCommands.join("\n")}
  }

}`;
  return template;
};
