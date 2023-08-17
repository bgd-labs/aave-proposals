import fs from 'fs';
import path from 'path';
import {Command, Option} from 'commander';
import {generateAIP, generateScript} from './templates';
import {
  AVAILABLE_CHAINS,
  AVAILABLE_VERSIONS,
  generateContractName,
  generateFolderName,
  pascalCase,
} from './common';
import {proposalTemplate} from './templates/proposal.template';
import {testTemplate} from './templates/test.template';
import {input, checkbox, select, confirm} from '@inquirer/prompts';
import {CodeArtifacts, FeatureModule, Options} from './types';
import {flashBorrower} from './features/flashBorrower';
import {capUpdates} from './features/capUpdate';
import {rateUpdates} from './features/rateUpdates';
import * as prettier from 'prettier';

const configFile = await prettier.resolveConfigFile();
const program = new Command();

program
  .name('proposal-generator')
  .description('CLI to generate aave proposals')
  .version('0.0.0')
  .addOption(new Option('-f, --force', 'force creation (might overwrite existing files)'))
  .addOption(new Option('-cfg, --configEngine', 'extends config engine'))
  .addOption(new Option('-ch, --chains <letters...>').choices(AVAILABLE_CHAINS))
  .addOption(new Option('-pv, --protocolVersion <string>').choices(AVAILABLE_VERSIONS))
  .addOption(new Option('-t, --title <string>', 'aip title'))
  .addOption(new Option('-a, --author <string>', 'author'))
  .addOption(new Option('-d, --discussion <string>', 'forum link'))
  .addOption(new Option('-s, --snapshot <string>', 'snapshot link'))
  .allowExcessArguments(false)
  .parse(process.argv);

let options = program.opts<Options>();

// workaround as there's validate is not currently supported on checkbox
// https://github.com/SBoudrias/Inquirer.js/issues/1257
while (!options.chains?.length === true) {
  options.chains = await checkbox({
    message: 'Chains this proposal targets',
    choices: AVAILABLE_CHAINS.map((v) => ({name: v, value: v})),
    // validate(input) {
    //   // currently ignored due to a bug
    //   if (input.length == 0) return 'You must target at least one chain in your proposal!';
    //   return true;
    // },
  });
}

if (!options.protocolVersion) {
  options.protocolVersion = await select({
    message: 'Protocol version this proposal targets',
    choices: AVAILABLE_VERSIONS.map((v) => ({name: v, value: v})).reverse(),
    // default: "V3", // default on select not currently supported which is why we reverse
  });
}

if (!options.title) {
  options.title = await input({
    message: 'Title of your proposal',
    validate(input) {
      if (input.length == 0) return "Your title can't be empty";
      return true;
    },
  });
}
options.shortName = pascalCase(options.title);

if (!options.author) {
  options.author = await input({
    message: 'Author of your proposal',
    validate(input) {
      if (input.length == 0) return "Your author can't be empty";
      return true;
    },
  });
}

if (!options.discussion) {
  options.discussion = await input({
    message: 'Link to forum discussion',
  });
}

if (!options.snapshot) {
  options.snapshot = await input({
    message: 'Link to snapshot',
  });
}

export const FEATURES = {
  rateStrategiesUpdates: {
    name: 'RateStrategyUpdates',
    value: 'rateStrategiesUpdates',
    module: rateUpdates,
  },
  capsUpdate: {
    name: 'CapsUpdate',
    value: 'capsUpdate',
    module: capUpdates,
  },
  flashBorrower: {
    name: 'Add an address as flash borrower',
    value: 'flashBorrower',
    module: flashBorrower,
  },
  others: {
    name: 'Something different',
    value: 'others',
  },
};

if (options.protocolVersion === 'V2') {
  options.features = await checkbox({
    message: 'What do you want to do?',
    choices: [FEATURES.rateStrategiesUpdates, FEATURES.others],
  });
}
if (options.protocolVersion === 'V3') {
  options.features = await checkbox({
    message: 'What do you want to do?',
    choices: [
      FEATURES.rateStrategiesUpdates,
      FEATURES.capsUpdate,
      FEATURES.flashBorrower,
      FEATURES.others,
    ],
  });
}

let artifacts: CodeArtifacts[] = [];
for (const feature of options.features) {
  const module: FeatureModule<any> = FEATURES[feature].module;
  if (module) {
    const cfg = await module.cli(options);
    artifacts.push(module.build(options, cfg));
  }
}

const baseName = generateFolderName(options);
const baseFolder = path.join(process.cwd(), 'src', baseName);

if (!options.force && fs.existsSync(baseFolder)) {
  options.force = await confirm({
    message: 'A proposal already exists at that location, do you want to override?',
    default: false,
  });
}
// create files
if (fs.existsSync(baseFolder) && !options.force) {
  console.log('Creation skipped as folder already exists.');
  console.log('If you want to overwrite, supply --force');
} else {
  fs.mkdirSync(baseFolder, {recursive: true});

  async function createFiles(options: Options, chain: string) {
    const contractName = generateContractName(options, chain);
    fs.writeFileSync(
      path.join(baseFolder, `${contractName}.sol`),
      prettier.format(
        proposalTemplate(
          {
            ...options,
            contractName,
            chain,
          },
          artifacts
        ),
        configFile
      )
    );
    fs.writeFileSync(
      path.join(baseFolder, `${contractName}.t.sol`),
      prettier.format(
        await testTemplate(
          {
            ...options,
            contractName,
            chain,
          },
          artifacts
        ),
        configFile
      )
    );
  }

  options.chains.forEach((chain) => createFiles(options, chain));

  fs.writeFileSync(
    path.join(baseFolder, `${generateContractName(options)}.s.sol`),
    prettier.format(generateScript(options, baseName), configFile)
  );
  fs.writeFileSync(
    path.join(baseFolder, `${options.shortName}.md`),
    prettier.format(generateAIP(options), configFile)
  );
}
