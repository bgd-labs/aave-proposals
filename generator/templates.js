import { generateChainName, generateName } from "./common.js";

const pragma = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;\n\n`;

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
