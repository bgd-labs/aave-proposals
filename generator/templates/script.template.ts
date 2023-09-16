import {
  CHAINS_WITH_GOV_SUPPORT,
  generateContractName,
  generateFolderName,
  getAlias,
  pragma,
} from '../common';
import {Options} from '../types';

export function generateScript(options: Options) {
  const folderName = generateFolderName(options);
  const fileName = generateContractName(options);
  let template = pragma;

  // generate imports
  template += `import {GovHelpers} from 'aave-helpers/GovHelpers.sol';\n`;
  template += `import {${['Ethereum', ...options.chains.filter((c) => c !== 'Ethereum')]
    .map((chain) => `${chain}Script`)
    .join(', ')}} from 'aave-helpers/ScriptUtils.sol';\n`;
  template += options.chains
    .map((chain) => {
      const name = generateContractName(options, chain);
      return `import {${name}} from './${name}.sol';`;
    })
    .join('\n');
  template += '\n\n';

  // generate chain scripts
  template += options.chains
    .map((chain) => {
      const name = generateContractName(options, chain);

      return `/**
 * @dev Deploy ${name}
 * command: make deploy-ledger contract=src/${folderName}/${fileName}.s.sol:Deploy${chain} chain=${getAlias(
        chain
      )}
 */
contract Deploy${chain} is ${chain}Script {
  function run() external broadcast {
    new ${name}();
  }
}`;
    })
    .join('\n\n');
  template += '\n\n';

  const supportedChains = options.chains.filter((chain) => CHAINS_WITH_GOV_SUPPORT.includes(chain));

  // generate proposal creation script
  template += `/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/${folderName}/${fileName}.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](${supportedChains.length});
${supportedChains
  .map(
    (chain, ix) =>
      `    payloads[${ix}] = GovHelpers.build${
        chain == 'Ethereum' ? 'Mainnet' : chain
      }(address(0));`
  )
  .join('\n')}
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/${folderName}/${
    options.shortName
  }.md'));
  }
}`;
  return template;
}
