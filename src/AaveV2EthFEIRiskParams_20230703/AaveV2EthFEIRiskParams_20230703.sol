// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV2PayloadEthereum, IEngine, EngineFlags, IV2RateStrategyFactory} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title This proposal updates FEI risk params on Aave V2 Ethereum
 * @author @yonikesel - ChaosLabsInc
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe6fbf8d933858a15ddb4ae6101ccaec3e16d01c8e9172fc2aa8a51972ec67837
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-fei-on-aave-v2-ethereum-2023-6-22/13782
 */
contract AaveV2EthFEIRiskParams_20230703 is AaveV2PayloadEthereum {
  uint256 public constant FEI_LTV = 0; /// 65 -> 0
  uint256 public constant FEI_LIQUIDATION_THRESHOLD = 1_00; // 75 -> 1
  uint256 public constant FEI_LIQUIDATION_BONUS = 11000; // 6.5 -> 10
  uint256 public constant FEI_UOPTIMAL = 1_00; // 80 -> 1
  address public constant NEW_FEI_ORACLE = 0xac3AF0f4A52C577Cc2C241dF51a01FDe3D06D93B;

  function _postExecute() internal override {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.FEI_UNDERLYING,
      FEI_LTV,
      FEI_LIQUIDATION_THRESHOLD,
      FEI_LIQUIDATION_BONUS
    );
  
    address[] memory assets = new address[](1);
    assets[0] = AaveV2EthereumAssets.FEI_UNDERLYING;
    address[] memory sources = new address[](1);
    sources[0] = NEW_FEI_ORACLE;
    AaveV2Ethereum.ORACLE.setAssetSources(assets, sources);
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategy = new IEngine.RateStrategyUpdate[](1);

    rateStrategy[0] = IEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.FEI_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(FEI_UOPTIMAL),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategy;
  }
}
