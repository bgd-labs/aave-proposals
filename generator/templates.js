import {
  CHAINS_WITH_GOV_SUPPORT,
  generateContractName,
  generateFolderName,
  getAlias,
} from "./common.js";

const pragma = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;\n\n`;

export function generateScript(options, baseName) {
  let template = pragma;
  // generate imports
  template += `import {GovHelpers} from 'aave-helpers/GovHelpers.sol';\n`;
  template += `import {${[
    "Ethereum",
    ...options.chains.filter((c) => c !== "Ethereum"),
  ]
    .map((chain) => `${chain}Script`)
    .join(", ")}} from 'aave-helpers/ScriptUtils.sol';\n`;
  template += options.chains
    .map((chain) => {
      const name = generateContractName(options, chain);
      return `import {${name}} from './${name}.sol';`;
    })
    .join("\n");
  template += "\n\n";

  // generate chain scripts
  template += options.chains
    .map((chain) => {
      const name = generateContractName(options, chain);

      return `/**
 * @dev Deploy ${name}
 * command: make deploy-ledger contract=src/${baseName}/${baseName}.s.sol:Deploy${chain} chain=${getAlias(
        chain
      )}
 */
contract Deploy${chain} is ${chain}Script {
  function run() external broadcast {
    new ${name}();
  }
}`;
    })
    .join("\n\n");
  template += "\n\n";

  const supportedChains = options.chains.filter((chain) =>
    CHAINS_WITH_GOV_SUPPORT.includes(chain)
  );

  // generate proposal creation script
  template += `/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/${baseName}/${baseName}.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](${
      supportedChains.length
    });
${supportedChains
  .map(
    (chain, ix) =>
      `    payloads[${ix}] = GovHelpers.build${
        chain == "Ethereum" ? "Mainnet" : chain
      }(address(0));`
  )
  .join("\n")}
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/${generateFolderName(
      options
    )}/${options.shortName}.md'));
  }
}`;
  return template;
}

export function generateAIP(options) {
  return `---
title: ${`"${options.title}"` || "TODO"}
author: ${`"${options.author}"` || "TODO"}
discussions: ${`"${options.discussion}"` || "TODO"}
---

## Simple Summary

## Motivation

## Specification

## References

- Implementation: ${options.chains
    .map(
      (chain) =>
        `[${chain}](https://github.com/bgd-labs/aave-proposals/blob/main/src/${generateFolderName(
          options
        )}/${generateContractName(options, chain)}.sol)`
    )
    .join(", ")}
- Tests: ${options.chains
    .map(
      (chain) =>
        `[${chain}](https://github.com/bgd-labs/aave-proposals/blob/main/src/${generateFolderName(
          options
        )}/${generateContractName(options, chain)}.t.sol)`
    )
    .join(", ")}
- [Snapshot](${options.snapshot || "TODO"})
- [Discussion](${options.discussion || "TODO"})

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).\n`;
}
