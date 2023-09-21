import {input, checkbox} from '@inquirer/prompts';
import {CodeArtifact, DEPENDENCIES, ENGINE_FLAGS, FeatureModule, PoolIdentifier} from '../types';
import {
  getAssets,
  jsNumberToSol,
  jsPercentToSol,
  numberOrKeepCurrent,
  transformPercent,
} from '../common';
import {
  NumberInputValues,
  PercentInputValues,
  eModeSelect,
  numberInput,
  percentInput,
} from '../prompts';

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
      ltv: await percentInput({
        message: 'Loan to value',
      }),
      liqThreshold: await percentInput({
        message: 'Liquidation Threshold',
      }),
      liqBonus: await percentInput({
        message: 'Liquidation bonus',
      }),
      debtCeiling: await numberInput({
        message: 'Debt ceiling',
      }),
      liqProtocolFee: await percentInput({
        message: 'Liquidation protocol fee',
      }),
      eModeCategory: await eModeSelect({
        message: 'e mode category',
        pool,
      }),
    });
  }
  return answers;
}
type CollateralUpdate = {
  asset: string;
  ltv: PercentInputValues;
  liqThreshold: PercentInputValues;
  liqBonus: PercentInputValues;
  debtCeiling: NumberInputValues;
  liqProtocolFee: PercentInputValues;
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
               ltv: ${cfg.ltv},
               liqThreshold: ${cfg.liqThreshold},
               liqBonus: ${cfg.liqBonus},
               debtCeiling: ${cfg.debtCeiling},
               liqProtocolFee: ${cfg.liqProtocolFee},
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
