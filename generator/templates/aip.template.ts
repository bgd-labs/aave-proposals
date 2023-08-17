import {generateContractName, generateFolderName} from '../common';
import {Options} from '../types';

export function generateAIP(options: Options) {
  return `---
title: ${`"${options.title}"` || 'TODO'}
author: ${`"${options.author}"` || 'TODO'}
discussions: ${`"${options.discussion}"` || 'TODO'}
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
    .join(', ')}
- Tests: ${options.chains
    .map(
      (chain) =>
        `[${chain}](https://github.com/bgd-labs/aave-proposals/blob/main/src/${generateFolderName(
          options
        )}/${generateContractName(options, chain)}.t.sol)`
    )
    .join(', ')}
- [Snapshot](${options.snapshot || 'TODO'})
- [Discussion](${options.discussion || 'TODO'})

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).\n`;
}
