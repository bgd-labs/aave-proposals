import {input, confirm} from '@inquirer/prompts';
import {CodeArtifacts, DEPENDENCIES, ENGINE_FLAGS, FeatureModule} from '../types';
import {jsNumberToSol, numberOrKeepCurrent} from '../common';

async function subCli(chain: string) {
  console.log(`Fetching information for CapsUpdates on ${chain}`);
  const answers = {
    asset: await input({
      // TODO: should be select, but npm package needs to be restructured a bit
      message: 'Which asset would you like to amend(type symbol)?',
    }),
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
  };
  const anotherOne = await confirm({
    message: 'Do you want to amend another cap?',
    default: false,
  });
  if (anotherOne) return [answers, ...(await subCli(chain))];
  return [answers];
}

type CapsUpdates = {
  [chain: string]: {
    asset: string;
    borrowCap: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
    supplyCap: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
  }[];
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
