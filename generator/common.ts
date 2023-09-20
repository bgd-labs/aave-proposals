import * as addressBook from '@bgd-labs/aave-address-book';
import {ENGINE_FLAGS, Options, PoolIdentifier, V2_POOLS} from './types';

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

export const SHORT_CHAINS = {
  Ethereum: 'Eth',
  Polygon: 'Pol',
  Optimism: 'Opt',
  Arbitrum: 'Arb',
  Fantom: 'Ftm',
  Avalanche: 'Ava',
  Metis: 'Met',
  Harmony: 'Har',
  Base: 'Bas',
};

export function getAssets(pool: PoolIdentifier): string[] {
  const assets = addressBook[pool].ASSETS;
  return Object.keys(assets);
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

export function getAlias(chain) {
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

export function numberOrKeepCurrent(value) {
  if (value != ENGINE_FLAGS.KEEP_CURRENT && isNaN(value)) return 'Must be number or KEEP_CURRENT';
  return true;
}

/**
 * Transforms the input for nicer readability: 1000 -> 10.00 %
 * @param value
 * @returns
 */
export function transformPercent(value: string) {
  if (value && !isNaN(Number(value))) {
    return value.replace(/(?=(\d{2}$)+(?!\d))/g, '.') + ' %';
  }
  return value;
}

/**
 * Transforms the % js output for nicer readability in sol: 1000 -> 10_00
 * @param value
 * @returns
 */
export function jsPercentToSol(value: string, bpsToRay?: boolean) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  if (bpsToRay) return `_bpsToRay(${value.replace(/(?=(\d{2}$))/g, '_')})`;
  return value.replace(/(?=(\d{2}$)+(?!\d))/g, '_');
}

/**
 * Transforms the number js output for nicer readability in sol: 1000000 -> 1_000_000
 * @param value
 * @returns
 */
export function jsNumberToSol(value: string) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  return value.replace(/\B(?=(\d{3})+(?!\d))/g, '_');
}

export const pragma = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;\n\n`;
