// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';

contract OpPayload is IProposalGenericExecutor, Test {
  // **************************
  // Protocol's contracts
  // **************************
  address public constant INCENTIVES_CONTROLLER =
    0x929EC64c34a17401F460460D4B9390518E5B473e;

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
    0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B;
  address public constant VDTOKEN_IMPL =
    0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3;
  address public constant SDTOKEN_IMPL =
    0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e;

  address public constant RATE_STRATEGY =
    0x41B66b4b6b4c9dab039d96528D1b88f7BAF8C5A4; // TODO: check no info

  uint256 public constant RESERVE_FACTOR = 3000; // 30%

  uint256 public constant SUPPLY_CAP = 1_000_000; // 1m OP
  uint256 public constant LIQ_PROTOCOL_FEE = 1000; // 10% TODO: check no info

  // params to set reserve as collateral
  uint256 public constant LIQ_THRESHOLD = 5000; // 80%
  uint256 public constant LTV = 3000; // 30%
  uint256 public constant LIQ_BONUS = 11200; // 12%

  function execute() external override {
    // -------------
    // Claim pool admin
    // Only needed for the first proposal on any market. If ACL_ADMIN was previously set it will ignore
    // https://github.com/aave/aave-v3-core/blob/master/contracts/dependencies/openzeppelin/contracts/AccessControl.sol#L207
    // -------------
    AaveV3Optimism.ACL_MANAGER.addPoolAdmin(AaveV3Optimism.ACL_ADMIN);

    // ----------------------------
    // 0. New price feed on oracle
    // ----------------------------
    address[] memory assets = new address[](1);
    assets[0] = UNDERLYING;
    address[] memory sources = new address[](1);
    sources[0] = PRICE_FEED;

    AaveV3Optimism.ORACLE.setAssetSources(assets, sources);

    // ------------------------------------------------
    // 1. Listing of MIMATIC, with all its configurations
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

    configurator.setReserveBorrowing(UNDERLYING, true);

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
