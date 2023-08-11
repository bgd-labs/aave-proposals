export const AVAILABLE_VERSIONS = ["V2", "V3"];

export const AVAILABLE_CHAINS = [
  "Ethereum",
  "Optimism",
  "Arbitrum",
  "Polygon",
  "Avalanche",
  "Fantom",
  "Harmony",
  "Metis",
];

export const CHAINS_WITH_GOV_SUPPORT = [
  "Ethereum",
  "Optimism",
  "Arbitrum",
  "Polygon",
  "Metis",
];

export const SHORT_CHAINS = {
  Ethereum: "Eth",
  Polygon: "Pol",
  Optimism: "Opt",
  Arbitrum: "Arb",
  Fantom: "Ftm",
  Avalanche: "Ava",
  Metis: "Met",
  Harmony: "Har",
};

export function getDate() {
  const date = new Date();
  const years = date.getFullYear();
  const months = date.getMonth() + 1; // it's js so months are 0 indexed
  const day = date.getDate();
  return `${years}${months <= 9 ? "0" : ""}${months}${
    day <= 9 ? "0" : ""
  }${day}`;
}

/**
 * Prefix with the date for proper sorting
 * @param {*} options
 * @returns
 */
export function generateFolderName(options) {
  return `${getDate()}_${
    options.protocolVersion === "V2" ? "AaveV2" : "AaveV3"
  }_${
    options.chains.length === 1 ? SHORT_CHAINS[options.chains[0]] : "Multi"
  }_${options.shortName}`;
}

/**
 * Suffix with the date as prefixing would generate invalid contract names
 * @param {*} options
 * @param {*} chain
 * @returns
 */
export function generateContractName(options, chain) {
  let name = options.protocolVersion === "V2" ? "AaveV2" : "AaveV3";
  if (chain) name += `_${chain}`;
  name += `_${options.shortName}`;
  name += `_${getDate()}`;
  return name;
}

export function getAlias(chain) {
  return chain === "Ethereum" ? "mainnet" : chain.toLowerCase();
}

export function pascalCase(str) {
  return str
    .replace(/(\w)(\w*)/g, function (g0, g1, g2) {
      return g1.toUpperCase() + g2;
    })
    .replace(/ /g, "");
}
