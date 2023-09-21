import {CodeArtifact, DEPENDENCIES, FeatureModule, PoolIdentifier} from '../types';
import {
  BooleanSelectValues,
  PercentInputValues,
  assetsSelect,
  booleanSelect,
  percentInput,
} from '../prompts';

async function subCli(pool: PoolIdentifier) {
  console.log(`Fetching information for BorrowUpdates on ${pool}`);
  const assets = await assetsSelect({
    message: 'Select the assets you want to amend',
    pool,
  });
  const answers: BorrowUpdate[] = [];
  for (const asset of assets) {
    console.log(`collecting info for ${asset}`);
    answers.push({
      asset,
      enabledToBorrow: await booleanSelect({
        message: 'enabled to borrow',
      }),
      flashloanable: await booleanSelect({
        message: 'flashloanable',
      }),
      stableRateModeEnabled: await booleanSelect({
        message: 'stable rate mode enabled',
      }),
      borrowableInIsolation: await booleanSelect({
        message: 'borrowable in isolation',
      }),
      withSiloedBorrowing: await booleanSelect({
        message: 'siloed borrowing',
      }),
      reserveFactor: await percentInput({
        message: 'reserve factor',
      }),
    });
  }
  return answers;
}

type BorrowUpdate = {
  asset: string;
  enabledToBorrow: BooleanSelectValues;
  flashloanable: BooleanSelectValues;
  stableRateModeEnabled: BooleanSelectValues;
  borrowableInIsolation: BooleanSelectValues;
  withSiloedBorrowing: BooleanSelectValues;
  reserveFactor: PercentInputValues;
};

type BorrowUpdates = BorrowUpdate[];

export const borrowsUpdates: FeatureModule<BorrowUpdates> = {
  value:
    'BorrowsUpdates (enabledToBorrow, flashloanable, stableRateModeEnabled, borrowableInIsolation, withSiloedBorrowing, reserveFactor)',
  async cli(opt, pool) {
    const response: BorrowUpdates = await subCli(pool);
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
