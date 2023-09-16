import {AVAILABLE_VERSIONS, ENGINE_FLAGS} from './types';

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

export const CHAIN_TO_EXECUTOR = {
  Ethereum: 'AaveGovernanceV2.SHORT_EXECUTOR',
  Polygon: 'AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR',
  Optimism: 'AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR',
  Arbitrum: 'AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR',
  Metis: 'AaveGovernanceV2.METIS_BRIDGE_EXECUTOR',
  Base: 'AaveGovernanceV2.BASE_BRIDGE_EXECUTOR',
  Avalanche: '0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian',
} as const;

export const CHAINS_WITH_GOV_SUPPORT = [
  'Ethereum',
  'Optimism',
  'Arbitrum',
  'Polygon',
  'Metis',
  'Base',
];

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
export function generateFolderName(options) {
  return `${getDate()}_${options.protocolVersion === AVAILABLE_VERSIONS.V2 ? 'AaveV2' : 'AaveV3'}_${
    options.chains.length === 1 ? SHORT_CHAINS[options.chains[0]] : 'Multi'
  }_${options.shortName}`;
}

/**
 * Suffix with the date as prefixing would generate invalid contract names
 * @param {*} options
 * @param {*} chain
 * @returns
 */
export function generateContractName(options, chain?) {
  let name = options.protocolVersion === AVAILABLE_VERSIONS.V2 ? 'AaveV2' : 'AaveV3';
  if (chain) name += `_${chain}`;
  name += `_${options.shortName}`;
  name += `_${getDate()}`;
  return name;
}

export function getAlias(chain) {
  return chain === 'Ethereum' ? 'mainnet' : chain.toLowerCase();
}

export function pascalCase(str) {
  return str
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
