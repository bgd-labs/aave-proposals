import {CodeArtifact, DEPENDENCIES, FeatureModule, PoolIdentifier} from '../types';
import {NumberInputValues, assetsSelect, numberInput} from '../prompts';

async function subCli(pool: PoolIdentifier) {
  console.log(`Fetching information for CapsUpdates on ${pool}`);
  const assets = await assetsSelect({
    message: 'Select the assets you want to amend',
    pool,
  });
  const answers: CapUpdate[] = [];
  for (const asset of assets) {
    console.log(`collecting info for ${asset}`);
    answers.push({
      asset,
      supplyCap: await numberInput({
        message: 'New supply cap',
      }),
      borrowCap: await numberInput({
        message: 'New borrow cap',
      }),
    });
  }
  return answers;
}

type CapUpdate = {
  asset: string;
  borrowCap: NumberInputValues;
  supplyCap: NumberInputValues;
};

type CapsUpdates = CapUpdate[];

export const capsUpdates: FeatureModule<CapsUpdates> = {
  value: 'CapsUpdates (supplyCap, borrowCap)',
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
               supplyCap: ${cfg.supplyCap},
               borrowCap: ${cfg.borrowCap}
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
