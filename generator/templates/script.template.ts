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
  template += `import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';\n`;
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
    ${name} payload = new ${name}();
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(address(payload)));
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
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](${
      supportedChains.length
    });
${supportedChains
  .map((chain, ix) => {
    let template = `payloads[${ix}] = GovV3Helpers.build${
      chain == 'Ethereum' ? 'Mainnet' : chain
    }(vm, GovV3Helpers.buildAction(address(0)));\n`;
    return template;
  })
  .join('\n')}
    GovV3Helpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/${folderName}/${
    options.shortName
  }.md'));
  }
}`;
  return template;
}
