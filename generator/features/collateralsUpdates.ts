import {input, checkbox} from '@inquirer/prompts';
import {CodeArtifact, DEPENDENCIES, ENGINE_FLAGS, FeatureModule, PoolIdentifier} from '../types';
import {
  getAssets,
  jsNumberToSol,
  jsPercentToSol,
  numberOrKeepCurrent,
  transformPercent,
} from '../common';

async function subCli(pool: PoolIdentifier) {
  console.log(`Fetching information for Collateral Updates on ${pool}`);
  const assets = await checkbox({
    message: 'Select the assets you want to amend',
    choices: getAssets(pool).map((asset) => ({name: asset, value: asset})),
  });
  const answers: CollateralUpdate[] = [];
  for (const asset of assets) {
    console.log(`collecting info for ${asset}`);
    answers.push({
      asset,
      ltv: await input({
        message: 'Loan to value',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        validate: numberOrKeepCurrent,
        transformer: transformPercent,
      }),
      liqThreshold: await input({
        message: 'Liquidation Threshold',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        validate: numberOrKeepCurrent,
        transformer: transformPercent,
      }),
      liqBonus: await input({
        message: 'Liquidation bonus',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        validate: numberOrKeepCurrent,
        transformer: transformPercent,
      }),
      debtCeiling: await input({
        message: 'Debt ceiling',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        validate: numberOrKeepCurrent,
      }),
      liqProtocolFee: await input({
        message: 'Liquidation protocol fee',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        validate: numberOrKeepCurrent,
        transformer: transformPercent,
      }),
      eModeCategory: await input({
        message: 'e mode category',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        validate: numberOrKeepCurrent,
      }),
    });
  }
  return answers;
}
type CollateralUpdate = {
  asset: string;
  ltv: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
  liqThreshold: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
  liqBonus: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
  debtCeiling: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
  liqProtocolFee: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
  eModeCategory: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
};

type CollateralUpdates = CollateralUpdate[];

export const collateralsUpdates: FeatureModule<CollateralUpdates> = {
  value: 'CollateralsUpdates (ltv,lt,lb,debtCeiling,liqProtocolFee,eModeCategory)',
  async cli(opt, pool) {
    const response: CollateralUpdates = await subCli(pool);
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        dependencies: [DEPENDENCIES.Assets, DEPENDENCIES.Engine],
        fn: [
          `function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
            IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](${
              cfg.length
            });

          ${cfg
            .map(
              (cfg, ix) => `collateralUpdate[${ix}] = IEngine.CollateralUpdate({
               asset: ${pool}Assets.${cfg.asset}_UNDERLYING,
               ltv: ${jsPercentToSol(cfg.ltv)},
               liqThreshold: ${jsPercentToSol(cfg.liqThreshold)},
               liqBonus: ${jsPercentToSol(cfg.liqBonus)},
               debtCeiling: ${jsNumberToSol(cfg.debtCeiling)},
               liqProtocolFee: ${jsPercentToSol(cfg.liqProtocolFee)},
               eModeCategory: ${
                 cfg.eModeCategory === ENGINE_FLAGS.KEEP_CURRENT
                   ? `EngineFlags.KEEP_CURRENT`
                   : cfg.eModeCategory
               }
             });`
            )
            .join('\n')}

          return collateralUpdate;
        }`,
        ],
      },
    };
    return response;
  },
};
