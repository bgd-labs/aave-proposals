// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';

/**
 * @dev Adding OP token to aave optimism pool.
 * Listing snapshot: https://snapshot.org/#/aave.eth/proposal/0x16d55ed730076b4f6ea09b9fcc62ea846b248a96f40fb3dbc6c1f193df013d6d
 * Parameter suggestions: https://governance.aave.com/t/arc-add-op-as-collateral-to-aave-v3/9087/7
 */
contract OpPayload is IProposalGenericExecutor {
  // **************************
  // Protocol's contracts
  // **************************
  address public constant INCENTIVES_CONTROLLER =
    AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER;

  // **************************
  // New asset being listed (OP)
  // **************************

  address public constant UNDERLYING =
    0x4200000000000000000000000000000000000042;
  string public constant ATOKEN_NAME = 'Aave Optimism OP';
  string public constant ATOKEN_SYMBOL = 'aOptOP';
  string public constant VDTOKEN_NAME = 'Aave Optimism Variable Debt OP';
  string public constant VDTOKEN_SYMBOL = 'variableDebtOptOP';
  string public constant SDTOKEN_NAME = 'Aave Optimism Stable Debt OP';
  string public constant SDTOKEN_SYMBOL = 'stableDebtOptOP';

  address public constant PRICE_FEED =
    0x0D276FC14719f9292D5C1eA2198673d1f4269246;

  address public constant ATOKEN_IMPL =
    AaveV3Optimism.DEFAULT_A_TOKEN_IMPL_REV_1;
  address public constant VDTOKEN_IMPL =
    AaveV3Optimism.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1;
  address public constant SDTOKEN_IMPL =
    AaveV3Optimism.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1;

  address public constant RATE_STRATEGY =
    0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C; // same as weth

  uint256 public constant RESERVE_FACTOR = 2000; // 20%

  uint256 public constant SUPPLY_CAP = 40_000_000; // 40m OP
  uint256 public constant LIQ_PROTOCOL_FEE = 1000; // 10%

  // params to set reserve as collateral
  uint256 public constant LIQ_THRESHOLD = 6500; // 65%
  uint256 public constant LTV = 5000; // 50%
  uint256 public constant LIQ_BONUS = 11000; // 10%

  function execute() external override {
    // ----------------------------
    // 0. New price feed on oracle
    // ----------------------------
    address[] memory assets = new address[](1);
    assets[0] = UNDERLYING;
    address[] memory sources = new address[](1);
    sources[0] = PRICE_FEED;

    AaveV3Optimism.ORACLE.setAssetSources(assets, sources);

    // ------------------------------------------------
    // 1. Listing of OP, with all its configurations
    // ------------------------------------------------

    ConfiguratorInputTypes.InitReserveInput[]
      memory initReserveInputs = new ConfiguratorInputTypes.InitReserveInput[](
        1
      );
    initReserveInputs[0] = ConfiguratorInputTypes.InitReserveInput({
      aTokenImpl: ATOKEN_IMPL,
      stableDebtTokenImpl: SDTOKEN_IMPL,
      variableDebtTokenImpl: VDTOKEN_IMPL,
      underlyingAssetDecimals: IERC20Metadata(UNDERLYING).decimals(),
      interestRateStrategyAddress: RATE_STRATEGY,
      underlyingAsset: UNDERLYING,
      treasury: AaveV3Optimism.COLLECTOR,
      incentivesController: INCENTIVES_CONTROLLER,
      aTokenName: ATOKEN_NAME,
      aTokenSymbol: ATOKEN_SYMBOL,
      variableDebtTokenName: VDTOKEN_NAME,
      variableDebtTokenSymbol: VDTOKEN_SYMBOL,
      stableDebtTokenName: SDTOKEN_NAME,
      stableDebtTokenSymbol: SDTOKEN_SYMBOL,
      params: bytes('')
    });

    IPoolConfigurator configurator = AaveV3Optimism.POOL_CONFIGURATOR;

    configurator.initReserves(initReserveInputs);

    configurator.setSupplyCap(UNDERLYING, SUPPLY_CAP);

    configurator.setReserveFactor(UNDERLYING, RESERVE_FACTOR);

    configurator.setLiquidationProtocolFee(UNDERLYING, LIQ_PROTOCOL_FEE);

    configurator.configureReserveAsCollateral(
      UNDERLYING,
      LTV,
      LIQ_THRESHOLD,
      LIQ_BONUS
    );
  }
}
