import {CodeArtifact, DEPENDENCIES, FeatureModule, PoolIdentifier} from '../types';
import {addressInput, stringInput} from '../prompts';
import {fetchBorrowUpdate} from './borrowsUpdates';
import {fetchRateStrategyParams} from './rateUpdates';
import {fetchCollateralUpdate} from './collateralsUpdates';
import {fetchCapsUpdate} from './capsUpdates';
import {Listing} from './types';

async function subCli(pool: PoolIdentifier): Promise<Listing> {
  console.log(`Fetching information for Emode assets on ${pool}`);
  const asset = await addressInput({
    message: 'select the asset you want to list',
    disableKeepCurrent: true,
  });
  return {
    assetSymbol: await stringInput({message: 'Enter the asset symbol', disableKeepCurrent: true}),
    priceFeed: await addressInput({message: 'PriceFeed address', disableKeepCurrent: true}),
    ...(await fetchCollateralUpdate(pool, true)),
    ...(await fetchBorrowUpdate(true)),
    ...(await fetchCapsUpdate(true)),
    rateStrategyParams: await fetchRateStrategyParams(pool, true),
    asset,
  };
}
type AssetListings = Listing[];

export const assetListing: FeatureModule<AssetListings> = {
  value: 'newListings (listing a new asset)',
  async cli(opt, pool) {
    const response: AssetListings = [];
    response.push(await subCli(pool));
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        dependencies: [DEPENDENCIES.Assets, DEPENDENCIES.Engine],
        fn: [
          `function newListings() public pure override returns (IEngine.Listing[] memory) {
          IEngine.Listing[] memory listings = new IEngine.Listing[](${cfg.length});

          ${cfg
            .map(
              (cfg, ix) => `listings[${ix}] = IEngine.Listing({
               asset: ${cfg.asset},
               assetSymbol: ${cfg.assetSymbol},
               priceFeed: ${cfg.priceFeed},
               eModeCategory: ${cfg.eModeCategory},
               enabledToBorrow: ${cfg.enabledToBorrow},
               stableRateModeEnabled: ${cfg.stableRateModeEnabled},
               borrowableInIsolation: ${cfg.borrowableInIsolation},
               withSiloedBorrowing: ${cfg.withSiloedBorrowing},
               flashloanable: ${cfg.flashloanable},
               ltv: ${cfg.ltv}
               liqThreshold: ${cfg.liqThreshold},
               liqBonus: ${cfg.liqBonus},
               reserveFactor: ${cfg.reserveFactor},
               supplyCap: ${cfg.supplyCap},
               borrowCap: ${cfg.borrowCap},
               debtCeiling: ${cfg.debtCeiling},
               liqProtocolFee: ${cfg.liqProtocolFee},
               rateStrategyParams: Rates.RateStrategyParams({
                  optimalUsageRatio: ${cfg.rateStrategyParams.optimalUtilizationRate},
                  baseVariableBorrowRate: ${cfg.rateStrategyParams.baseVariableBorrowRate},
                  variableRateSlope1: ${cfg.rateStrategyParams.variableRateSlope1},
                  variableRateSlope2: ${cfg.rateStrategyParams.variableRateSlope2},
                  stableRateSlope1: ${cfg.rateStrategyParams.stableRateSlope1},
                  stableRateSlope2: ${cfg.rateStrategyParams.stableRateSlope2},
                  baseStableRateOffset: ${cfg.rateStrategyParams.baseStableRateOffset},
                  stableRateExcessOffset: ${cfg.rateStrategyParams.stableRateExcessOffset},
                  optimalStableToTotalDebtRatio: ${cfg.rateStrategyParams.optimalStableToTotalDebtRatio}
              })
             });`
            )
            .join('\n')}

          return listings;
        }`,
        ],
      },
    };
    return response;
  },
};
