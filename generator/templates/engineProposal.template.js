import { ENGINE_FEATURES } from "../generator.js";

function renderPostHook() {
  return `function _postExecute() internal override {

  }\n\n`;
}

function renderV2IRUpgrades() {
  return `function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategies = new IEngine.RateStrategyUpdate[](1);

    // rateStrategies[0] = IEngine.RateStrategyUpdate({
    //   asset: AaveV2PolygonAssets.DAI_UNDERLYING,
    //   params: Rates.RateStrategyParams({
    //     optimalUtilizationRate: _bpsToRay(71_00),
    //     baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
    //     variableRateSlope1: EngineFlags.KEEP_CURRENT,
    //     variableRateSlope2: _bpsToRay(105_00),
    //     stableRateSlope1: EngineFlags.KEEP_CURRENT,
    //     stableRateSlope2: _bpsToRay(105_00)
    //   })
    // });

    return rateStrategies;
  }\n\n`;
}

function renderV3IRUpgrades() {
  return `function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategies = new IEngine.RateStrategyUpdate[](1);

    // rateStrategies[0] = IEngine.RateStrategyUpdate({
    //   asset: AaveV3ArbitrumAssets.WETH_UNDERLYING,
    //   params: Rates.RateStrategyParams({
    //     optimalUsageRatio: _bpsToRay(80_00),
    //     baseVariableBorrowRate: _bpsToRay(1_00),
    //     variableRateSlope1: _bpsToRay(3_80),
    //     variableRateSlope2: _bpsToRay(80_00),
    //     stableRateSlope1: _bpsToRay(4_00),
    //     stableRateSlope2: _bpsToRay(80_00),
    //     baseStableRateOffset: _bpsToRay(3_00),
    //     stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
    //     optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
    //   })
    // });

    return rateStrategies;
  }\n\n`;
}

function renderV3CapsUpdate() {
  return `function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    // capsUpdate[0] = IEngine.CapsUpdate({
    //   asset: AaveV3PolygonAssets.EURS_UNDERLYING,
    //   supplyCap: EngineFlags.KEEP_CURRENT,
    //   borrowCap: 1_500_000
    // });

    return capsUpdate;
  }\n\n`;
}

export const engineProposalTemplate = (options) => {
  const {
    protocolVersion,
    chain,
    title,
    author,
    snapshot,
    discussion,
    contractName,
  } = options;
  let template = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Aave${protocolVersion}Payload${chain}, IEngine, Rates, EngineFlags} from 'aave-helpers/${protocolVersion.toLowerCase()}-config-engine/Aave${protocolVersion}Payload${chain}.sol';
import {Aave${protocolVersion}${chain}, Aave${protocolVersion}${chain}Assets} from 'aave-address-book/Aave${protocolVersion}${chain}.sol';

/**
 * @title ${title || "TODO"}
 * @author ${author || "TODO"}
 * - Snapshot: ${snapshot || "TODO"}
 * - Discussion: ${discussion || "TODO"}
 */
contract ${contractName} is Aave${protocolVersion}Payload${chain} {\n`;

  if (options.features.includes(ENGINE_FEATURES.postHook.value))
    template += renderPostHook();
  if (options.features.includes(ENGINE_FEATURES.rateStrategiesUpdates.value)) {
    if (options.protocolVersion == "V2") template += renderV2IRUpgrades();
    else template += renderV3IRUpgrades();
  }
  if (options.features.includes(ENGINE_FEATURES.capsUpdate.value)) {
    template += renderV3CapsUpdate();
  }
  template += "}";
  return template;
};
