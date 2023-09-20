import {checkbox, input} from '@inquirer/prompts';
import {
  AVAILABLE_VERSIONS,
  CodeArtifact,
  DEPENDENCIES,
  ENGINE_FLAGS,
  FeatureModule,
  PoolIdentifier,
} from '../types';
import {
  getAssets,
  isV2Pool,
  jsPercentToSol,
  numberOrKeepCurrent,
  transformPercent,
} from '../common';

type RateUpdate = {
  asset: string;
  optimalUtilizationRate: string;
  baseVariableBorrowRate: string;
  variableRateSlope1: string;
  variableRateSlope2: string;
  stableRateSlope1: string;
  stableRateSlope2: string;
  baseStableRateOffset?: string;
  stableRateExcessOffset?: string;
  optimalStableToTotalDebtRatio?: string;
};

type RateUpdates = RateUpdate[];

async function subCli(pool: PoolIdentifier) {
  console.log(`Fetching information for RatesUpdate on ${pool}`);
  const assets = await checkbox({
    message: 'Select the assets you want to amend',
    choices: getAssets(pool).map((asset) => ({
      name: asset,
      value: asset,
    })),
  });
  const answers: RateUpdates = [];
  for (const asset of assets) {
    answers.push({
      asset,
      optimalUtilizationRate: await input({
        message: 'optimalUtilizationRate',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        transformer: transformPercent,
        validate: numberOrKeepCurrent,
      }),
      baseVariableBorrowRate: await input({
        message: 'baseVariableBorrowRate',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        transformer: transformPercent,
        validate: numberOrKeepCurrent,
      }),
      variableRateSlope1: await input({
        message: 'variableRateSlope1',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        transformer: transformPercent,
        validate: numberOrKeepCurrent,
      }),
      variableRateSlope2: await input({
        message: 'variableRateSlope2',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        transformer: transformPercent,
        validate: numberOrKeepCurrent,
      }),
      stableRateSlope1: await input({
        message: 'stableRateSlope1',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        transformer: transformPercent,
        validate: numberOrKeepCurrent,
      }),
      stableRateSlope2: await input({
        message: 'stableRateSlope2',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        transformer: transformPercent,
        validate: numberOrKeepCurrent,
      }),
    });

    if (!isV2Pool(pool)) {
      answers[answers.length - 1].baseStableRateOffset = await input({
        message: 'baseStableRateOffset',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        transformer: transformPercent,
        validate: numberOrKeepCurrent,
      });
      answers[answers.length - 1].stableRateExcessOffset = await input({
        message: 'stableRateExcessOffset',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        transformer: transformPercent,
        validate: numberOrKeepCurrent,
      });
      answers[answers.length - 1].optimalStableToTotalDebtRatio = await input({
        message: 'stableRateExcessOffset',
        default: ENGINE_FLAGS.KEEP_CURRENT,
        transformer: transformPercent,
        validate: numberOrKeepCurrent,
      });
    }
  }
  return answers;
}

export const rateUpdates: FeatureModule<RateUpdates> = {
  async cli(opt, pool) {
    const response: RateUpdates = await subCli(pool);
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        dependencies: [DEPENDENCIES.Assets, DEPENDENCIES.Engine],
        execute: [`${pool}.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);`],
        fn: [
          `function rateStrategiesUpdates()
          public
          pure
          override
          returns (IEngine.RateStrategyUpdate[] memory)
        {
          IEngine.RateStrategyUpdate[] memory rateStrategies = new IEngine.RateStrategyUpdate[](${
            cfg.length
          });
          ${
            isV2Pool(pool)
              ? cfg
                  .map(
                    (cfg, ix) => `rateStrategies[${ix}] = IEngine.RateStrategyUpdate({
                asset: ${pool}Assets.${cfg.asset}_UNDERLYING,
                params: Rates.RateStrategyParams({
                  optimalUtilizationRate: ${jsPercentToSol(cfg.optimalUtilizationRate, true)},
                  baseVariableBorrowRate: ${jsPercentToSol(cfg.baseVariableBorrowRate, true)},
                  variableRateSlope1: ${jsPercentToSol(cfg.variableRateSlope1, true)},
                  variableRateSlope2: ${jsPercentToSol(cfg.variableRateSlope2, true)},
                  stableRateSlope1: ${jsPercentToSol(cfg.stableRateSlope1, true)},
                  stableRateSlope2: ${jsPercentToSol(cfg.stableRateSlope2, true)}
                })
              });`
                  )
                  .join('\n')
              : cfg
                  .map(
                    (cfg, ix) => `rateStrategies[${ix}] = IEngine.RateStrategyUpdate({
                  asset: ${pool}Assets.${cfg.asset}_UNDERLYING,
                  params: Rates.RateStrategyParams({
                    optimalUsageRatio: ${jsPercentToSol(cfg.optimalUtilizationRate, true)},
                    baseVariableBorrowRate: ${jsPercentToSol(cfg.baseVariableBorrowRate, true)},
                    variableRateSlope1: ${jsPercentToSol(cfg.variableRateSlope1, true)},
                    variableRateSlope2: ${jsPercentToSol(cfg.variableRateSlope2, true)},
                    stableRateSlope1: ${jsPercentToSol(cfg.stableRateSlope1, true)},
                    stableRateSlope2: ${jsPercentToSol(cfg.stableRateSlope2, true)},
                    baseStableRateOffset: ${jsPercentToSol(cfg.baseStableRateOffset!, true)},
                    stableRateExcessOffset: ${jsPercentToSol(cfg.stableRateExcessOffset!, true)},
                    optimalStableToTotalDebtRatio: ${jsPercentToSol(
                      cfg.optimalStableToTotalDebtRatio!,
                      true
                    )}
                  })
                });`
                  )
                  .join('\n')
          }


          return rateStrategies;
        }`,
        ],
      },
    };
    return response;
  },
};
