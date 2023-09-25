// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2PayloadEthereum, IEngine, EngineFlags} from 'lib/aave-helpers/src/v2-config-engine/AaveV2PayloadEthereum.sol';
import {IV2RateStrategyFactory} from 'lib/aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';

/**
 * @title TUSD Offboarding Plan Part II
 * @author Marc Zeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x95cca29a9cdcaf51bb7331a9516d643a5c88f8ddce86c5f3920c2ae4d604193f
 * - Discussion: https://governance.aave.com/t/arfc-tusd-offboarding-plan-part-ii/14863
 */
contract AaveV2_Ethereum_TUSDOffboardingPlanPartII_20230925 is AaveV2PayloadEthereum {
  function _preExecute() internal override {
    uint256 aBUSDBalance = IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 availableBUSD = IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(
      AaveV2EthereumAssets.BUSD_A_TOKEN
    );
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.BUSD_A_TOKEN,
      address(this),
      aBUSDBalance > availableBUSD ? availableBUSD : aBUSDBalance
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      type(uint256).max,
      address(AaveV2Ethereum.COLLECTOR)
    );

    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      99_90
    );

    uint256 aTUSDBalance = IERC20(AaveV2EthereumAssets.TUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 availableTUSD = IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(
      AaveV2EthereumAssets.TUSD_A_TOKEN
    );
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.TUSD_A_TOKEN,
      address(this),
      aTUSDBalance > availableTUSD ? availableTUSD : aTUSDBalance
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      type(uint256).max,
      address(AaveV2Ethereum.COLLECTOR)
    );
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategy = new IEngine.RateStrategyUpdate[](1);

    rateStrategy[0] = IEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.TUSD_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(1_00),
        baseVariableBorrowRate: _bpsToRay(100_00),
        variableRateSlope1: _bpsToRay(70_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(70_00),
        stableRateSlope2: _bpsToRay(300_00)
      })
    });

    return rateStrategy;
  }
}
