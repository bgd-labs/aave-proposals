// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2PayloadEthereum, IEngine, EngineFlags} from 'lib/aave-helpers/src/v2-config-engine/AaveV2PayloadEthereum.sol';
import {IV2RateStrategyFactory} from 'lib/aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';


/**
 * @title [ARFC] BUSD Offboarding Plan part III
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x389c0cd79720fd9853ca6714f4597484dd25cc3a5e34955bf6144f0ba1888a3a
 * - Discussion: https://governance.aave.com/t/arfc-busd-offboarding-plan-part-iii/14136
 */
contract AaveV2EthBUSDIR_20230804 is AaveV2PayloadEthereum {
  address public constant INTEREST_RATE_STRATEGY = 0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69;

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

    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      INTEREST_RATE_STRATEGY
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
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(200_00)
      })
    });

    return rateStrategy;
  }
}
