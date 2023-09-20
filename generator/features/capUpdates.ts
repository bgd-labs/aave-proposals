import {input, checkbox} from '@inquirer/prompts';
import {CodeArtifact, DEPENDENCIES, ENGINE_FLAGS, FeatureModule, PoolIdentifier} from '../types';
import {getAssets, jsNumberToSol, numberOrKeepCurrent} from '../common';

async function subCli(pool: PoolIdentifier) {
  console.log(`Fetching information for CapsUpdates on ${pool}`);
  const assets = await checkbox({
    message: 'Select the assets you want to amend',
    choices: getAssets(pool).map((asset) => ({name: asset, value: asset})),
  });
  const answers: CapUpdate[] = [];
  for (const asset of assets) {
    answers.push({
      asset,
      supplyCap: await input({
        message: 'New supply cap',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        validate: numberOrKeepCurrent,
      }),
      borrowCap: await input({
        message: 'New borrow cap',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        validate: numberOrKeepCurrent,
      }),
    });
  }
  return answers;
}

type CapUpdate = {
  asset: string;
  borrowCap: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
  supplyCap: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
};

type CapsUpdates = CapUpdate[];

export const capUpdates: FeatureModule<CapsUpdates> = {
  async cli(opt, pool) {
    const response: CapsUpdates = await subCli(pool);
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        dependencies: [DEPENDENCIES.Assets, DEPENDENCIES.Engine],
        fn: [
          `function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
          IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](${cfg.length});

          ${cfg
            .map(
              (cfg, ix) => `capsUpdate[${ix}] = IEngine.CapsUpdate({
               asset: ${pool}Assets.${cfg.asset}_UNDERLYING,
               supplyCap: ${jsNumberToSol(cfg.supplyCap)},
               borrowCap: ${jsNumberToSol(cfg.borrowCap)}
             });`
            )
            .join('\n')}

          return capsUpdate;
        }`,
        ],
      },
    };
    return response;
  },
};
