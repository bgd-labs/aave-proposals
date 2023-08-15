import {input, confirm} from '@inquirer/prompts';
import {CodeArtifacts, FeatureModule} from '../types';

function numberOrKeepCurrent(value) {
  if (value != 'KEEP_CURRENT' && isNaN(value)) return 'Must be number or KEEP_CURRENT';
  return true;
}

async function subCli(chain: string) {
  console.log(`Fetching information for CapsUpdates on ${chain}`);
  const answers = {
    asset: await input({
      // TODO: should be select, but npm package needs to be restructured a bit
      message: 'Which asset would you like to amend(type symbol)?',
    }),
    borrowCap: await input({
      message: 'New borrow cap',
      default: 'KEEP_CURRENT',
      validate: numberOrKeepCurrent,
    }),
    supplyCap: await input({
      message: 'New supply cap',
      default: 'KEEP_CURRENT',
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

type CapsUpdate = {
  [chain: string]: {
    asset: string;
    borrowCap: 'KEEP_CURRENT' | number;
    supplyCap: 'KEEP_CURRENT' | number;
  }[];
};

export const capUpdates: FeatureModule<CapsUpdate> = {
  async cli(opt) {
    const response: CapsUpdate = {};
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
          imports: ['ASSETS', 'IENGINE'],
          fn: [
            `function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
            IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](${cfg[chain].length});

            ${cfg[chain]
              .map(
                (cfg) => `capsUpdate[0] = IEngine.CapsUpdate({
                 asset: Aave${opt.protocolVersion}${chain}Assets.${cfg.asset}_UNDERLYING,
                 supplyCap: ${
                   cfg.supplyCap === 'KEEP_CURRENT' ? 'EngineFlags.KEEP_CURRENT' : cfg.supplyCap
                 },
                 borrowCap: ${
                   cfg.borrowCap === 'KEEP_CURRENT' ? 'EngineFlags.KEEP_CURRENT' : cfg.borrowCap
                 }
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
