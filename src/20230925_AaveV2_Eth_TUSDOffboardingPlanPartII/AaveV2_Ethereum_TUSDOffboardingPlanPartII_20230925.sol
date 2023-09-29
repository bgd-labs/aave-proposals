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
  uint256 public constant TUSD_LTV = 0;
  uint256 public constant TUSD_LIQUIDATION_THRESHOLD = 65_00;
  uint256 public constant TUSD_LIQUIDATION_BONUS = 11000;
  uint256 public constant RESERVE_FACTOR = 99_90;

  function _preExecute() internal override {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      TUSD_LTV,
      TUSD_LIQUIDATION_THRESHOLD,
      TUSD_LIQUIDATION_BONUS
    );

    collectorATokenToUnderlying(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      AaveV2EthereumAssets.BUSD_A_TOKEN
    );
    collectorATokenToUnderlying(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV2EthereumAssets.TUSD_A_TOKEN
    );

    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      RESERVE_FACTOR
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

  function collectorATokenToUnderlying(address underlying, address aToken) internal {
    uint256 aBalance = IERC20(aToken).balanceOf(address(AaveV2Ethereum.COLLECTOR));

    uint256 availableUnderlying = IERC20(underlying).balanceOf(aToken);

    uint256 amount = aBalance > availableUnderlying ? availableUnderlying : aBalance;

    AaveV2Ethereum.COLLECTOR.transfer(aToken, address(this), amount);

    AaveV2Ethereum.POOL.withdraw(underlying, amount, address(AaveV2Ethereum.COLLECTOR));
  }
}
