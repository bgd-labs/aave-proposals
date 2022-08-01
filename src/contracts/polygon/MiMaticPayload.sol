// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import 'forge-std/console.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IERC20} from '../../interfaces/IERC20.sol';

interface IProposalGenericExecutor {
  function execute() external;
}

/**
 * @dev This payload lists MIMATIC (MAI) as borrowing asset on Aave V3 Polygon
 * - Parameter snapshot: https://snapshot.org/#/aave.eth/proposal/0x751b8fd1c77677643e419d327bdf749c29ccf0a0269e58ed2af0013843376051
 * The proposal is, as agreed with the proposer, more conservative than the approved parameters:
 * - Not enabled as collateral initially and thus not be isolated / have a debt ceiling.
 * - The eMode lq treshold will be 97.5, instead of the suggested 98% as the parameters are per emode not per asset
 * - Adding a 10M supply cap.
 */
contract MiMaticPayload is IProposalGenericExecutor {
  // **************************
  // Protocol's contracts
  // **************************
  address public constant INCENTIVES_CONTROLLER =
    0x929EC64c34a17401F460460D4B9390518E5B473e;

  // **************************
  // New asset being listed (MIMATIC)
  // **************************

  address public constant UNDERLYING =
    0xa3Fa99A148fA48D14Ed51d610c367C61876997F1;
  string public constant ATOKEN_NAME = 'Aave Polygon MIMATIC';
  string public constant ATOKEN_SYMBOL = 'aAvaMIMATIC';
  string public constant VDTOKEN_NAME = 'Aave Polygon Variable Debt MIMATIC';
  string public constant VDTOKEN_SYMBOL = 'variableDebtAvaMIMATIC';
  string public constant SDTOKEN_NAME = 'Aave Polygon Stable Debt MIMATIC';
  string public constant SDTOKEN_SYMBOL = 'stableDebtAvaMIMATIC';

  address public constant PRICE_FEED =
    0xd8d483d813547CfB624b8Dc33a00F2fcbCd2D428;

  address public constant ATOKEN_IMPL =
    0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B;
  address public constant VDTOKEN_IMPL =
    0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3;
  address public constant SDTOKEN_IMPL =
    0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e;
  address public constant RATE_STRATEGY =
    0xf4a0039F2d4a2EaD5216AbB6Ae4C4C3AA2dB9b82;

  uint256 public constant RESERVE_FACTOR = 1000; // 10%

  uint256 public constant SUPPLY_CAP = 10_000_000; // 10m
  uint256 public constant LIQ_PROTOCOL_FEE = 1000; // 10%

  uint8 public constant EMODE_CATEGORY = 1; // Stablecoins

  function execute() external override {
    // -------------
    // 0. Claim pool
    AaveV3Polygon.ACL_MANAGER.addPoolAdmin(AaveV3Polygon.ACL_ADMIN);

    // ----------------------------
    // 1. New price feed on oracle
    // ----------------------------
    address[] memory assets = new address[](1);
    assets[0] = UNDERLYING;
    address[] memory sources = new address[](1);
    sources[0] = PRICE_FEED;

    AaveV3Polygon.ORACLE.setAssetSources(assets, sources);

    // ------------------------------------------------
    // 2. Listing of MIMATIC, with all its configurations
    // ------------------------------------------------

    ConfiguratorInputTypes.InitReserveInput[]
      memory initReserveInputs = new ConfiguratorInputTypes.InitReserveInput[](
        1
      );
    initReserveInputs[0] = ConfiguratorInputTypes.InitReserveInput({
      aTokenImpl: ATOKEN_IMPL,
      stableDebtTokenImpl: SDTOKEN_IMPL,
      variableDebtTokenImpl: VDTOKEN_IMPL,
      underlyingAssetDecimals: IERC20(UNDERLYING).decimals(),
      interestRateStrategyAddress: RATE_STRATEGY,
      underlyingAsset: UNDERLYING,
      treasury: AaveV3Polygon.COLLECTOR,
      incentivesController: INCENTIVES_CONTROLLER,
      aTokenName: ATOKEN_NAME,
      aTokenSymbol: ATOKEN_SYMBOL,
      variableDebtTokenName: VDTOKEN_NAME,
      variableDebtTokenSymbol: VDTOKEN_SYMBOL,
      stableDebtTokenName: SDTOKEN_NAME,
      stableDebtTokenSymbol: SDTOKEN_SYMBOL,
      params: bytes('')
    });

    IPoolConfigurator configurator = AaveV3Polygon.POOL_CONFIGURATOR;

    configurator.initReserves(initReserveInputs);

    configurator.setSupplyCap(UNDERLYING, SUPPLY_CAP);

    configurator.setReserveBorrowing(UNDERLYING, true);

    configurator.setReserveFactor(UNDERLYING, RESERVE_FACTOR);

    configurator.setAssetEModeCategory(UNDERLYING, EMODE_CATEGORY);

    configurator.setLiquidationProtocolFee(UNDERLYING, LIQ_PROTOCOL_FEE);
  }
}
