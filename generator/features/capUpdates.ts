import {input, confirm, checkbox} from '@inquirer/prompts';
import {CodeArtifacts, DEPENDENCIES, ENGINE_FLAGS, FeatureModule} from '../types';
import {getAssets, jsNumberToSol, numberOrKeepCurrent} from '../common';

async function subCli(chain: string) {
  console.log(`Fetching information for CapsUpdates on ${chain}`);
  const assets = await checkbox({
    message: 'Select the assets you want to amend',
    choices: getAssets(chain as any, 'V3').map((asset) => ({name: asset, value: asset})),
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

type CapsUpdates = {
  [chain: string]: CapUpdate[];
};

export const capUpdates: FeatureModule<CapsUpdates> = {
  async cli(opt) {
    const response: CapsUpdates = {};
    for (const chain of opt.chains) {
      response[chain] = await subCli(chain);
    }
    return response;
  },
  build(opt, cfg) {
    const response: CodeArtifacts = {};
    for (const chain of opt.chains) {
      response[chain] = {
        code: {
          dependencies: [DEPENDENCIES.Assets, DEPENDENCIES.Engine],
          fn: [
            `function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
            IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](${cfg[chain].length});

            ${cfg[chain]
              .map(
                (cfg, ix) => `capsUpdate[${ix}] = IEngine.CapsUpdate({
                 asset: Aave${opt.protocolVersion}${chain}Assets.${cfg.asset}_UNDERLYING,
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
    }
    return response;
  },
};
