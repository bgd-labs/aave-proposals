import * as addressBook from '@bgd-labs/aave-address-book';
import {Options, PoolIdentifier, PoolIdentifierV3, V2_POOLS} from './types';

export const AVAILABLE_CHAINS = [
  'Ethereum',
  'Optimism',
  'Arbitrum',
  'Polygon',
  'Avalanche',
  'Fantom',
  'Harmony',
  'Metis',
  'Base',
] as const;

export const CHAINS_WITH_GOV_SUPPORT = [
  'Ethereum',
  'Optimism',
  'Arbitrum',
  'Polygon',
  'Metis',
  'Base',
] as const satisfies readonly (typeof AVAILABLE_CHAINS)[number][];

export function getAssets(pool: PoolIdentifier): string[] {
  const assets = addressBook[pool].ASSETS;
  return Object.keys(assets);
}

export function getEModes(pool: PoolIdentifierV3) {
  const eModes = addressBook[pool].E_MODES;
  return eModes;
}

export function isV2Pool(pool: PoolIdentifier) {
  return V2_POOLS.includes(pool as any);
}

export function getVersion(pool: PoolIdentifier) {
  return isV2Pool(pool) ? 'V2' : 'V3';
}

export function getPoolChain(pool: PoolIdentifier) {
  const chain = AVAILABLE_CHAINS.find((chain) => pool.indexOf(chain) !== -1);
  if (!chain) throw new Error('cannot find chain for pool');
  return chain;
}

export function getDate() {
  const date = new Date();
  const years = date.getFullYear();
  const months = date.getMonth() + 1; // it's js so months are 0 indexed
  const day = date.getDate();
  return `${years}${months <= 9 ? '0' : ''}${months}${day <= 9 ? '0' : ''}${day}`;
}

/**
 * Prefix with the date for proper sorting
 * @param {*} options
 * @returns
 */
export function generateFolderName(options: Options) {
  return `${getDate()}_${options.pools.length === 1 ? options.pools[0] : 'Multi'}_${
    options.shortName
  }`;
}

/**
 * Suffix with the date as prefixing would generate invalid contract names
 * @param {*} options
 * @param {*} chain
 * @returns
 */
export function generateContractName(options: Options, pool?: PoolIdentifier) {
  let name = pool ? `${pool}_` : '';
  name += `${options.shortName}`;
  name += `_${getDate()}`;
  return name;
}

export function getChainAlias(chain) {
  return chain === 'Ethereum' ? 'mainnet' : chain.toLowerCase();
}

export function pascalCase(str: string) {
  return str
    .replace(/[\W]/g, ' ') // remove special chars as this is used for solc contract name
    .replace(/(\w)(\w*)/g, function (g0, g1, g2) {
      return g1.toUpperCase() + g2;
    })
    .replace(/ /g, '');
}

export const pragma = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;\n\n`;

export function generateDependencies();
