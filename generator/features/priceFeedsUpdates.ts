import {CodeArtifact, DEPENDENCIES, FeatureModule, PoolIdentifier} from '../types';
import {NumberInputValues, addressInput, assetsSelect, numberInput} from '../prompts';

async function subCli(pool: PoolIdentifier) {
  console.log(`Fetching information for PriceFeeds on ${pool}`);
  const assets = await assetsSelect({
    message: 'Select the assets you want to amend',
    pool,
  });
  const answers: PriceFeedUpdate[] = [];
  for (const asset of assets) {
    console.log(`collecting info for ${asset}`);
    answers.push({
      asset,
      priceFeed: await addressInput({
        message: 'New price feed address',
      }),
    });
  }
  return answers;
}

type PriceFeedUpdate = {
  asset: string;
  priceFeed: NumberInputValues;
};

type PriceFeedUpdates = PriceFeedUpdate[];

export const priceFeedsUpdates: FeatureModule<PriceFeedUpdates> = {
  value: 'PriceFeedsUpdates (replacing priceFeeds)',
  async cli(opt, pool) {
    const response: PriceFeedUpdates = await subCli(pool);
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        dependencies: [DEPENDENCIES.Assets, DEPENDENCIES.Engine],
        fn: [
          `function priceFeedsUpdates() public pure override returns (IEngine.PriceFeedUpdate[] memory) {
          IEngine.PriceFeedUpdate[] memory priceFeedsUpdates = new IEngine.PriceFeedUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `priceFeedsUpdates[${ix}] = IEngine.PriceFeedUpdate({
               asset: ${pool}Assets.${cfg.asset}_UNDERLYING,
               priceFeed: ${cfg.priceFeed}
             });`
            )
            .join('\n')}

          return priceFeedsUpdates;
        }`,
        ],
      },
    };
    return response;
  },
};
