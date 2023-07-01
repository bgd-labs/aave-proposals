import { generateChainName, generateName } from "./common.js";

const pragma = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;\n\n`;

export function generateProposal(options, chain) {
  let template = pragma;
  if (options.configEngine) {
    template += `import {Aave${
      options.protocolVersion
    }Payload${chain}, IEngine, Rates, EngineFlags} from 'aave-helpers/${options.protocolVersion.toLowerCase()}-config-engine/Aave${
      options.protocolVersion
    }Payload${chain}.sol';\n`;
    template += `import {Aave${options.protocolVersion}${chain},Aave${options.protocolVersion}${chain}Assets} from 'aave-address-book/AaveV3${chain}.sol';\n`;
  } else {
    template += `import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';\n`;
  }
  template += "\n\n";
  template += `/**
 * @title ${options.title || "TODO"}
 * @author ${options.author || "TODO"}
 * - Snapshot: ${options.snapshot || "TODO"}
 * - Discussion: ${options.discussion || "TODO"}
 */\n`;
  if (options.configEngine) {
    template += `contract ${generateChainName(options, chain)} is Aave${
      options.protocolVersion
    }Payload${chain} {


}`;
  } else {
    template += `contract ${generateChainName(
      options,
      chain
    )} is IProposalGenericExecutor {

  function execute() external {

  }

}`;
  }
  return template;
}

export function generateTest(options, chain) {
  let template = pragma;
  return template;
}

export function generateScript(options) {
  let template = pragma;
  // generate imports
  template += `import {GovHelpers} from 'aave-helpers/GovHelpers.sol';\n`;
  template += `import {${options.chains
    .map((chain) => `${chain}Script`)
    .join(", ")}} from 'aave-helpers/ScriptUtils.sol';\n`;
  template += options.chains
    .map((chain) => {
      const name = generateChainName(options, chain);
      return `import {${name}} from './${name}.sol';`;
    })
    .join("\n");
  template += "\n\n";

  // generate chain scripts
  template += options.chains
    .map((chain) => {
      const name = generateChainName(options, chain);

      return `contract Deploy${chain} is ${chain}Script {
  function run() external broadcast {
    new ${name}();
  }
}`;
    })
    .join("\n\n");
  template += "\n\n";

  // generate proposal creation script
  template += `contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](${
      options.chains.length
    });
    ${options.chains
      .map(
        (chain, ix) =>
          `payloads[${ix}] = GovHelpers.build${
            chain == "Ethereum" ? "Mainnet" : chain
          }(address(0));`
      )
      .join("\n")}
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/${generateName(
      options
    )}/${options.name}.md'));
  }
}`;
  return template;
}

export function generateAIP(options) {
  return `---
title: ${options.title || ""}
author: ${options.author || ""}
discussions: ${options.discussion || ""}
---

## Simple Summary

## Motivation

## Specification

## References

- Implementation: ${options.chains
    .map(
      (chain) =>
        `[${chain}](src/${generateName(options)}/${generateChainName(
          options,
          chain
        )}.sol)`
    )
    .join(", ")}
- Tests: ${options.chains
    .map(
      (chain) =>
        `[${chain}](src/${generateName(options)}/${generateChainName(
          options,
          chain
        )}.t.sol)`
    )
    .join(", ")}
- [Snapshot](${options.snapshot || "TODO"})
- [Discussion](${options.discussion || "TODO"})

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).\n`;
}
