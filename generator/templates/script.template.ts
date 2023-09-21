import {
  CHAINS_WITH_GOV_SUPPORT,
  generateContractName,
  generateFolderName,
  getChainAlias,
  getPoolChain,
  pragma,
} from '../common';
import {Options} from '../types';

export function generateScript(options: Options) {
  const folderName = generateFolderName(options);
  const fileName = generateContractName(options);
  let template = pragma;
  const chains = [...new Set(options.pools.map((pool) => getPoolChain(pool)!))];

  // generate imports
  template += `import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';\n`;
  template += `import {${['Ethereum', ...chains.filter((c) => c !== 'Ethereum')]
    .map((chain) => `${chain}Script`)
    .join(', ')}} from 'aave-helpers/ScriptUtils.sol';\n`;
  template += options.pools
    .map((pool) => {
      const name = generateContractName(options, pool);
      return `import {${name}} from './${name}.sol';`;
    })
    .join('\n');
  template += '\n\n';

  // generate chain scripts
  template += options.pools
    .map((pool) => {
      const name = generateContractName(options, pool);
      const chain = getPoolChain(pool);

      return `/**
 * @dev Deploy ${name}
 * command: make deploy-ledger contract=src/${folderName}/${fileName}.s.sol:Deploy${pool} chain=${getChainAlias(
        chain
      )}
 */
contract Deploy${pool} is ${chain}Script {
  function run() external broadcast {
    ${name} payload = new ${name}();
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(address(payload)));
  }
}`;
    })
    .join('\n\n');
  template += '\n\n';

  const poolsWithGovSupport = options.pools.filter((pool) =>
    CHAINS_WITH_GOV_SUPPORT.includes(getPoolChain(pool) as any)
  );

  // generate proposal creation script
  template += `/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/${folderName}/${fileName}.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](${
      poolsWithGovSupport.length
    });
${poolsWithGovSupport
  .map((pool, ix) => {
    const chain = getPoolChain(pool);
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
