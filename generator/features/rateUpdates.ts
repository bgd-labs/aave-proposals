import {confirm, input} from '@inquirer/prompts';
import {CodeArtifacts, DEPENDENCIES, ENGINE_FLAGS, FeatureModule} from '../types';
import {jsPercentToSol, numberOrKeepCurrent, transformPercent} from '../common';

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
type RateUpdates = {
  [chain: string]: RateUpdate[];
};

async function subCli(opt, chain: string) {
  console.log(`Fetching information for RatesUpdate on ${chain}`);
  const answers: RateUpdate = {
    asset: await input({
      // TODO: should be select, but npm package needs to be restructured a bit
      message: 'Which asset would you like to amend(type symbol)?',
    }),
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
  };
  if (opt.protocolVersion === 'V3') {
    answers.baseStableRateOffset = await input({
      message: 'baseStableRateOffset',
      default: ENGINE_FLAGS.KEEP_CURRENT,
      transformer: transformPercent,
      validate: numberOrKeepCurrent,
    });
    answers.stableRateExcessOffset = await input({
      message: 'stableRateExcessOffset',
      default: ENGINE_FLAGS.KEEP_CURRENT,
      transformer: transformPercent,
      validate: numberOrKeepCurrent,
    });
    answers.optimalStableToTotalDebtRatio = await input({
      message: 'stableRateExcessOffset',
      default: ENGINE_FLAGS.KEEP_CURRENT,
      transformer: transformPercent,
      validate: numberOrKeepCurrent,
    });
  }
  const anotherOne = await confirm({
    message: 'Do you want to amend another rate?',
    default: false,
  });
  if (anotherOne) return [answers, ...(await subCli(opt, chain))];
  return [answers];
}

export const rateUpdates: FeatureModule<RateUpdates> = {
  async cli(opt) {
    const response: RateUpdates = {};
    for (const chain of opt.chains) {
      response[chain] = await subCli(opt, chain);
    }
    return response;
  },
  build(opt, cfg) {
    const response: CodeArtifacts = {};
    for (const chain of opt.chains) {
      response[chain] = {
        code: {
          dependencies: [DEPENDENCIES.Assets, DEPENDENCIES.Engine],
          execute: [
            `Aave${opt.protocolVersion}${chain}.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);`,
          ],
          fn: [
            `function rateStrategiesUpdates()
            public
            pure
            override
            returns (IEngine.RateStrategyUpdate[] memory)
          {
            IEngine.RateStrategyUpdate[] memory rateStrategies = new IEngine.RateStrategyUpdate[](${
              cfg[chain].length
            });
            ${
              opt.protocolVersion === 'V2'
                ? cfg[chain]
                    .map(
                      (cfg, ix) => `rateStrategies[${ix}] = IEngine.RateStrategyUpdate({
                  asset: Aave${opt.protocolVersion}${chain}Assets.${cfg.asset}_UNDERLYING,
                  params: Rates.RateStrategyParams({
                    optimalUtilizationRate: ${jsPercentToSol(cfg.optimalUtilizationRate)},
                    baseVariableBorrowRate: ${jsPercentToSol(cfg.baseVariableBorrowRate)},
                    variableRateSlope1: ${jsPercentToSol(cfg.variableRateSlope1)},
                    variableRateSlope2: ${jsPercentToSol(cfg.variableRateSlope2)},
                    stableRateSlope1: ${jsPercentToSol(cfg.stableRateSlope1)},
                    stableRateSlope2: ${jsPercentToSol(cfg.stableRateSlope2)}
                  })
                });`
                    )
                    .join('\n')
                : cfg[chain]
                    .map(
                      (cfg, ix) => `rateStrategies[0] = IEngine.RateStrategyUpdate({
                    asset: Aave${opt.protocolVersion}${chain}Assets.${cfg.asset}_UNDERLYING,
                    params: Rates.RateStrategyParams({
                      optimalUsageRatio: ${jsPercentToSol(cfg.optimalUtilizationRate)},
                      baseVariableBorrowRate: ${jsPercentToSol(cfg.baseVariableBorrowRate)},
                      variableRateSlope1: ${jsPercentToSol(cfg.variableRateSlope1)},
                      variableRateSlope2: ${jsPercentToSol(cfg.variableRateSlope2)},
                      stableRateSlope1: ${jsPercentToSol(cfg.stableRateSlope1)},
                      stableRateSlope2: ${jsPercentToSol(cfg.stableRateSlope2)},
                      baseStableRateOffset: ${jsPercentToSol(cfg.baseStableRateOffset!)},
                      stableRateExcessOffset: ${jsPercentToSol(cfg.stableRateExcessOffset!)},
                      optimalStableToTotalDebtRatio: ${jsPercentToSol(
                        cfg.optimalStableToTotalDebtRatio!
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
    }
    return response;
  },
};
