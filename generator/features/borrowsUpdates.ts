import {CodeArtifact, DEPENDENCIES, FeatureModule} from '../types';
import {
  BooleanSelectValues,
  PercentInputValues,
  assetsSelect,
  booleanSelect,
  percentInput,
} from '../prompts';

export async function fetchBorrowUpdate(disableKeepCurrent?: boolean): Promise<BorrowUpdate> {
  return {
    enabledToBorrow: await booleanSelect({
      message: 'enabled to borrow',
      disableKeepCurrent,
    }),
    flashloanable: await booleanSelect({
      message: 'flashloanable',
      disableKeepCurrent,
    }),
    stableRateModeEnabled: await booleanSelect({
      message: 'stable rate mode enabled',
      disableKeepCurrent,
    }),
    borrowableInIsolation: await booleanSelect({
      message: 'borrowable in isolation',
      disableKeepCurrent,
    }),
    withSiloedBorrowing: await booleanSelect({
      message: 'siloed borrowing',
      disableKeepCurrent,
    }),
    reserveFactor: await percentInput({
      message: 'reserve factor',
      disableKeepCurrent,
    }),
  };
}

type BorrowUpdate = {
  enabledToBorrow: BooleanSelectValues;
  flashloanable: BooleanSelectValues;
  stableRateModeEnabled: BooleanSelectValues;
  borrowableInIsolation: BooleanSelectValues;
  withSiloedBorrowing: BooleanSelectValues;
  reserveFactor: PercentInputValues;
};

type BorrowUpdates = (BorrowUpdate & {asset: string})[];

export const borrowsUpdates: FeatureModule<BorrowUpdates> = {
  value:
    'BorrowsUpdates (enabledToBorrow, flashloanable, stableRateModeEnabled, borrowableInIsolation, withSiloedBorrowing, reserveFactor)',
  async cli(opt, pool) {
    const assets = await assetsSelect({
      message: 'Select the assets you want to amend',
      pool,
    });
    const response: BorrowUpdates = [];
    for (const asset of assets) {
      console.log(`Fetching information for BorrowUpdates on ${pool} ${asset}`);
      response.push({...(await getBorrowUpdateParams()), asset});
    }
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        dependencies: [DEPENDENCIES.Assets, DEPENDENCIES.Engine],
        fn: [
          `function borrowsUpdates() public pure override returns (IEngine.BorrowUpdate[] memory) {
          IEngine.BorrowUpdate[] memory borrowUpdates = new IEngine.BorrowUpdate[](${cfg.length});

          ${cfg
            .map(
              (cfg, ix) => `borrowUpdates[${ix}] = IEngine.BorrowUpdate({
               asset: ${pool}Assets.${cfg.asset}_UNDERLYING,
               enabledToBorrow: ${cfg.enabledToBorrow},
               flashloanable: ${cfg.flashloanable},
               stableRateModeEnabled: ${cfg.stableRateModeEnabled},
               borrowableInIsolation: ${cfg.borrowableInIsolation},
               withSiloedBorrowing: ${cfg.withSiloedBorrowing},
               reserveFactor: ${cfg.reserveFactor}
             });`
            )
            .join('\n')}

          return borrowUpdates;
        }`,
        ],
      },
    };
    return response;
  },
};
