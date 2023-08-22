import {input, confirm} from '@inquirer/prompts';
import {CodeArtifacts, DEPENDENCIES, ENGINE_FLAGS, FeatureModule} from '../types';
import {jsNumberToSol, jsPercentToSol, numberOrKeepCurrent, transformPercent} from '../common';

async function subCli(chain: string) {
  console.log(`Fetching information for Collateral Updates on ${chain}`);
  const answers = {
    asset: await input({
      // TODO: should be select, but npm package needs to be restructured a bit
      message: 'Which asset would you like to amend(type symbol)?',
    }),
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
  };
  const anotherOne = await confirm({
    message: 'Do you want to amend another cap?',
    default: false,
  });
  if (anotherOne) return [answers, ...(await subCli(chain))];
  return [answers];
}

type CollateralUpdates = {
  [chain: string]: {
    asset: string;
    ltv: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
    liqThreshold: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
    liqBonus: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
    debtCeiling: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
    liqProtocolFee: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
    eModeCategory: typeof ENGINE_FLAGS.KEEP_CURRENT | string;
  }[];
};

export const collateralUpdates: FeatureModule<CollateralUpdates> = {
  async cli(opt) {
    const response: CollateralUpdates = {};
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
              IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](${
                cfg[chain].length
              });

            ${cfg[chain]
              .map(
                (cfg, ix) => `capsUpdate[${ix}] = IEngine.CapsUpdate({
                 asset: Aave${opt.protocolVersion}${chain}Assets.${cfg.asset}_UNDERLYING,
                 ltv: ${jsPercentToSol(cfg.ltv)},
                 liqThreshold: ${jsPercentToSol(cfg.liqThreshold)},
                 liqBonus: ${jsPercentToSol(cfg.liqBonus)},
                 debtCeiling: ${jsNumberToSol(cfg.debtCeiling)},
                 liqProtocolFee: ${jsPercentToSol(cfg.liqProtocolFee)},
                 eModeCategory: ${cfg.eModeCategory}
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
