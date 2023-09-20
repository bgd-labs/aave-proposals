import fs from 'fs';
import path from 'path';
import {Command, Option} from 'commander';
import {generateContractName, generateFolderName, pascalCase} from './common';
import {proposalTemplate} from './templates/proposal.template';
import {testTemplate} from './templates/test.template';
import {input, checkbox, confirm} from '@inquirer/prompts';
import {
  CodeArtifact,
  DEPENDENCIES,
  Feature,
  FeatureModule,
  Options,
  POOLS,
  PoolConfigs,
  PoolIdentifier,
  V2_POOLS,
  V3_POOLS,
} from './types';
import {flashBorrower} from './features/flashBorrower';
import {capUpdates} from './features/capUpdates';
import {rateUpdates} from './features/rateUpdates';
import prettier from 'prettier';
import {generateScript} from './templates/script.template';
import {generateAIP} from './templates/aip.template';
import {collateralUpdates} from './features/collateralUpdates';

const prettierSolCfg = await prettier.resolveConfig('foo.sol');
const prettierMDCfg = await prettier.resolveConfig('foo.md');

const program = new Command();

program
  .name('proposal-generator')
  .description('CLI to generate aave proposals')
  .version('0.0.0')
  .addOption(new Option('-f, --force', 'force creation (might overwrite existing files)'))
  .addOption(new Option('-p, --pools <pools...>').choices(POOLS))
  .addOption(new Option('-t, --title <string>', 'aip title'))
  .addOption(new Option('-a, --author <string>', 'author'))
  .addOption(new Option('-d, --discussion <string>', 'forum link'))
  .addOption(new Option('-s, --snapshot <string>', 'snapshot link'))
  .allowExcessArguments(false)
  .parse(process.argv);

let options = program.opts<Options>();

// workaround as there's validate is not currently supported on checkbox
// https://github.com/SBoudrias/Inquirer.js/issues/1257
while (!options.pools?.length === true) {
  options.pools = await checkbox({
    message: 'Chains this proposal targets',
    choices: POOLS.map((v) => ({name: v, value: v})),
    // validate(input) {
    //   // currently ignored due to a bug
    //   if (input.length == 0) return 'You must target at least one chain in your proposal!';
    //   return true;
    // },
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

export const FEATURES: {[key: string]: Feature} = {
  rateStrategiesUpdates: {
    name: 'Rate Strategy Updates',
    value: 'rateStrategiesUpdates',
    module: rateUpdates,
  },
  capsUpdates: {
    name: 'Caps Updates',
    value: 'capsUpdates',
    module: capUpdates,
  },
  collateralUpdates: {
    name: 'Collateral Updates',
    value: 'collateralUpdates',
    module: collateralUpdates,
  },
  flashBorrower: {
    name: 'Add an address as flash borrower',
    value: 'flashBorrower',
    module: flashBorrower,
  },
  // this module is a workaround as long as we don't support all generator features
  engine: {
    name: 'Something different supported by config engine(but not the generator, yet)',
    value: 'engine',
    module: {
      cli: async (opt, pool) => {
        return {};
      },
      build: (opt, pool, cfg) => {
        const response: CodeArtifact = {
          code: {dependencies: [DEPENDENCIES.Engine]},
        };
        return response;
      },
    },
  },
  others: {
    name: 'Something different not supported by configEngine',
    value: 'others',
  },
} as const;

const poolConfigs: PoolConfigs = {};

for (const pool of options.pools) {
  const features: (keyof typeof FEATURES)[] = await checkbox({
    message: `What do you want to do on ${pool}?`,
    choices: V2_POOLS.includes(pool as any)
      ? [FEATURES.rateStrategiesUpdates, FEATURES.others]
      : [
          FEATURES.rateStrategiesUpdates,
          FEATURES.capsUpdates,
          FEATURES.collateralUpdates,
          FEATURES.flashBorrower,
          FEATURES.others,
        ],
  });
  let artifacts: CodeArtifact[] = [];
  for (const feature of features) {
    const module: FeatureModule | undefined = FEATURES[feature].module;
    if (module) {
      const cfg = await module.cli(options, pool);
      artifacts.push(module.build(options, pool, cfg));
    }
  }
  poolConfigs[pool] = {artifacts};
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

  async function createFiles(options: Options, pool: PoolIdentifier) {
    const contractName = generateContractName(options, pool);
    fs.writeFileSync(
      path.join(baseFolder, `${contractName}.sol`),
      prettier.format(proposalTemplate(options, pool, poolConfigs[pool]?.artifacts), {
        ...prettierSolCfg,
        filepath: 'foo.sol',
      })
    );
    fs.writeFileSync(
      path.join(baseFolder, `${contractName}.t.sol`),
      prettier.format(await testTemplate(options, pool, poolConfigs[pool]?.artifacts), {
        ...prettierSolCfg,
        filepath: 'foo.sol',
      })
    );
  }

  options.pools.forEach((pool) => createFiles(options, pool));

  fs.writeFileSync(
    path.join(baseFolder, `${generateContractName(options)}.s.sol`),
    prettier.format(generateScript(options), {
      ...prettierSolCfg,
      filepath: 'foo.sol',
    })
  );
  fs.writeFileSync(
    path.join(baseFolder, `${options.shortName}.md`),
    prettier.format(generateAIP(options), {
      ...prettierMDCfg,
      filepath: 'foo.md',
    })
  );
}
