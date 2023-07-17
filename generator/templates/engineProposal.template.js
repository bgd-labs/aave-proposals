export const engineProposalTemplate = ({
  protocolVersion,
  chain,
  title,
  author,
  snapshot,
  discussion,
  contractName,
}) => `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Aave${protocolVersion}Payload${chain}, IEngine, Rates, EngineFlags} from 'aave-helpers/${protocolVersion.toLowerCase()}-config-engine/Aave${protocolVersion}Payload${chain}.sol';
import {Aave${protocolVersion}${chain}, Aave${protocolVersion}${chain}Assets} from 'aave-address-book/Aave${protocolVersion}${chain}.sol';


/**
 * @title ${title || "TODO"}
 * @author ${author || "TODO"}
 * - Snapshot: ${snapshot || "TODO"}
 * - Discussion: ${discussion || "TODO"}
 */
contract ${contractName} is Aave${protocolVersion}Payload${chain} {


}`;
