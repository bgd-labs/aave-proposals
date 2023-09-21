import {CodeArtifact, DEPENDENCIES, FeatureModule, PoolIdentifier} from '../types';
import {isV2Pool} from '../common';
import {assetsSelect, percentInput} from '../prompts';

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
  const assets = await assetsSelect({
    message: 'Select the assets you want to amend',
    pool,
  });
  const answers: RateUpdates = [];
  for (const asset of assets) {
    console.log(`collecting info for ${asset}`);
    answers.push({
      asset,
      optimalUtilizationRate: await percentInput({
        message: 'optimalUtilizationRate',
        toRay: true,
      }),
      baseVariableBorrowRate: await percentInput({
        message: 'baseVariableBorrowRate',
        toRay: true,
      }),
      variableRateSlope1: await percentInput({
        message: 'variableRateSlope1',
        toRay: true,
      }),
      variableRateSlope2: await percentInput({
        message: 'variableRateSlope2',
        toRay: true,
      }),
      stableRateSlope1: await percentInput({
        message: 'stableRateSlope1',
        toRay: true,
      }),
      stableRateSlope2: await percentInput({
        message: 'stableRateSlope2',
        toRay: true,
      }),
    });

    if (!isV2Pool(pool)) {
      answers[answers.length - 1].baseStableRateOffset = await percentInput({
        message: 'baseStableRateOffset',
        toRay: true,
      });
      answers[answers.length - 1].stableRateExcessOffset = await percentInput({
        message: 'stableRateExcessOffset',
        toRay: true,
      });
      answers[answers.length - 1].optimalStableToTotalDebtRatio = await percentInput({
        message: 'stableRateExcessOffset',
        toRay: true,
      });
    }
  }
  return answers;
}

export const rateUpdates: FeatureModule<RateUpdates> = {
  value: 'RateStrategiesUpdates',
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
                  optimalUtilizationRate: ${cfg.optimalUtilizationRate},
                  baseVariableBorrowRate: ${cfg.baseVariableBorrowRate},
                  variableRateSlope1: ${cfg.variableRateSlope1},
                  variableRateSlope2: ${cfg.variableRateSlope2},
                  stableRateSlope1: ${cfg.stableRateSlope1},
                  stableRateSlope2: ${cfg.stableRateSlope2}
                })
              });`
                  )
                  .join('\n')
              : cfg
                  .map(
                    (cfg, ix) => `rateStrategies[${ix}] = IEngine.RateStrategyUpdate({
                  asset: ${pool}Assets.${cfg.asset}_UNDERLYING,
                  params: Rates.RateStrategyParams({
                    optimalUsageRatio: ${cfg.optimalUtilizationRate},
                    baseVariableBorrowRate: ${cfg.baseVariableBorrowRate},
                    variableRateSlope1: ${cfg.variableRateSlope1},
                    variableRateSlope2: ${cfg.variableRateSlope2},
                    stableRateSlope1: ${cfg.stableRateSlope1},
                    stableRateSlope2: ${cfg.stableRateSlope2},
                    baseStableRateOffset: ${cfg.baseStableRateOffset!},
                    stableRateExcessOffset: ${cfg.stableRateExcessOffset!},
                    optimalStableToTotalDebtRatio: ${cfg.optimalStableToTotalDebtRatio!}
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
